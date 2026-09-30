import 'package:flutter/material.dart';

import '../data/user_stores.dart';
import '../models/seller.dart';
import '../models/store.dart';
import '../widgets/category_carousel.dart';
import 'seller_central_screen.dart';

// Cadastro do vendedor e criação (ou edição) de uma loja própria
class StoreFormScreen extends StatefulWidget {
  // Loja a editar; nulo quando é uma loja nova
  final Store? store;

  const StoreFormScreen({super.key, this.store});

  @override
  State<StoreFormScreen> createState() => _StoreFormScreenState();
}

class _StoreFormScreenState extends State<StoreFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Cadastro do vendedor
  final _sellerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Dados da loja
  final _storeNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _sloganController = TextEditingController();
  final _imageUrlController = TextEditingController();

  static final List<String> segments = CategoryCarousel.categories
      .where((category) => category != 'Tudo')
      .toList();

  static const List<Color> brandColors = [
    Colors.deepPurple,
    Colors.orange,
    Color(0xFFD32F2F),
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFF00838F),
    Color(0xFFC2185B),
    Color(0xFF212121),
  ];

  String? _segment;
  Color _color = brandColors.first;
  bool _acceptedTerms = false;

  bool get isEditing => widget.store != null;

  @override
  void initState() {
    super.initState();

    final seller = UserStores.seller;
    if (seller != null) {
      _sellerNameController.text = seller.name;
      _emailController.text = seller.email;
      _phoneController.text = seller.phone;
    }

    final store = widget.store;
    if (store != null) {
      _storeNameController.text = store.name;
      _addressController.text = store.address;
      _sloganController.text = store.slogan;
      _imageUrlController.text = store.imageUrl;
      _segment = segments.contains(store.segment) ? store.segment : null;
      _color = store.color;
      _acceptedTerms = true;
    }

    // Atualiza a prévia da foto enquanto o usuário digita
    _imageUrlController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _sellerNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _storeNameController.dispose();
    _addressController.dispose();
    _sloganController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final error = _required(value);
    if (error != null) {
      return error;
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value!.trim())) {
      return 'Informe um e-mail válido';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final error = _required(value);
    if (error != null) {
      return error;
    }
    final digits = value!.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10 || digits.length > 11) {
      return 'Informe o telefone com DDD';
    }
    return null;
  }

  String? _validateImageUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (!value.trim().startsWith('http')) {
      return 'O link deve começar com http:// ou https://';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Aceite os termos para continuar'),
        ),
      );
      return;
    }

    UserStores.saveSeller(
      Seller(
        name: _sellerNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
      ),
    );

    final store = Store(
      id: widget.store?.id ?? 'user-${DateTime.now().millisecondsSinceEpoch}',
      name: _storeNameController.text.trim(),
      segment: _segment!,
      address: _addressController.text.trim(),
      slogan: _sloganController.text.trim(),
      imageUrl: _imageUrlController.text.trim(),
      color: _color,
    );

    if (isEditing) {
      UserStores.update(store);
      Navigator.of(context).pop();
    } else {
      UserStores.add(store);
      // Leva direto para a Central de Vendedores, onde a loja nova aparece
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SellerCentralScreen()),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        content: Text(
          isEditing
              ? 'Loja "${store.name}" atualizada'
              : 'Loja "${store.name}" criada com sucesso!',
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _imageUrlController.text.trim();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isEditing ? 'Editar loja' : 'Vender',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (!isEditing) ...[
              // Apresentação
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.storefront_outlined,
                      size: 40,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Crie sua loja no Feira + e venda para clientes '
                        'de Feira de Santana e região.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Cadastro do vendedor
            const _FormSectionTitle(
              title: 'Seus dados',
              subtitle: 'Usados para entrarmos em contato com você',
            ),
            TextFormField(
              controller: _sellerNameController,
              textCapitalization: TextCapitalization.words,
              decoration: _inputDecoration(
                'Nome completo',
                Icons.person_outline,
              ),
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('E-mail', Icons.email_outlined),
              validator: _validateEmail,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration(
                'Telefone / WhatsApp',
                Icons.phone_outlined,
                hint: '(75) 99999-9999',
              ),
              validator: _validatePhone,
            ),

            const SizedBox(height: 28),

            // Dados da loja
            const _FormSectionTitle(
              title: 'Sua loja',
              subtitle: 'Como a loja vai aparecer para os clientes',
            ),
            TextFormField(
              controller: _storeNameController,
              textCapitalization: TextCapitalization.words,
              decoration: _inputDecoration(
                'Nome da loja',
                Icons.storefront_outlined,
              ),
              validator: _required,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _segment,
              decoration: _inputDecoration('Segmento', Icons.category_outlined),
              items: segments.map((segment) {
                return DropdownMenuItem(value: segment, child: Text(segment));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _segment = value;
                });
              },
              validator: (value) {
                return value == null ? 'Escolha um segmento' : null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressController,
              textCapitalization: TextCapitalization.sentences,
              decoration: _inputDecoration(
                'Endereço',
                Icons.location_on_outlined,
                hint: 'Rua, número – bairro',
              ),
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sloganController,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 60,
              decoration: _inputDecoration(
                'Frase de apresentação',
                Icons.chat_bubble_outline,
                hint: 'Ex.: Os melhores preços do centro',
              ),
              validator: _required,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: _imageUrlController,
              keyboardType: TextInputType.url,
              decoration: _inputDecoration(
                'Link da foto da loja (opcional)',
                Icons.image_outlined,
                hint: 'https://...',
              ),
              validator: _validateImageUrl,
            ),

            // Prévia da foto
            if (imageUrl.startsWith('http')) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  height: 160,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade100,
                        alignment: Alignment.center,
                        child: const Text(
                          'Não foi possível carregar a foto',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Cor da marca
            const Text(
              'Cor da loja',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: brandColors.map((color) {
                final isSelected = color.toARGB32() == _color.toARGB32();

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _color = color;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.orange : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            if (!isEditing)
              CheckboxListTile(
                value: _acceptedTerms,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.deepPurple,
                title: const Text(
                  'Li e aceito os termos de uso para vendedores do Feira +',
                  style: TextStyle(fontSize: 14),
                ),
                onChanged: (value) {
                  setState(() {
                    _acceptedTerms = value ?? false;
                  });
                },
              ),
          ],
        ),
      ),

      // Botão de salvar
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: ElevatedButton.icon(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(isEditing ? Icons.save_outlined : Icons.add_business),
            label: Text(
              isEditing ? 'Salvar alterações' : 'Criar minha loja',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormSectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _FormSectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
