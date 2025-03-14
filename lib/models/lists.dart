class TodoLists {
  TodoLists({
    required this.title,
    required this.description,
    required this.success,
  });
  String title;
  String description;
  bool success;
}

List<TodoLists> data = [
  TodoLists(
    title: "ไปเที่ยว",
    description:
        "วางแผนไปเที่ยวทะเลกับเพื่อนที่หัวหิน ออกเดินทางเช้าวันเสาร์ กลับวันอาทิตย์ตอนค่ำ จองที่พักแล้ว เหลือหาร้านอาหารทะเลอร่อยๆ ไปลองกิน",
    success: true,
  ),
  TodoLists(
    title: "ซื้อของเข้าบ้าน",
    description:
        "ไปซูเปอร์มาร์เก็ตเพื่อซื้อของที่จำเป็น เช่น ข้าวสาร น้ำมันพืช ผักสด เนื้อสัตว์ และของใช้ส่วนตัวอย่างสบู่ แชมพู และกระดาษทิชชู่",
    success: false,
  ),
  TodoLists(
    title: "ออกกำลังกาย",
    description:
        "ไปวิ่งที่สวนลุมพินีช่วงเย็น ตั้งเป้าวิ่งให้ได้อย่างน้อย 5 กิโลเมตร และปิดท้ายด้วยการยืดกล้ามเนื้อกับออกกำลังกายเวทเทรนนิ่งเบาๆ",
    success: false,
  ),
  TodoLists(
    title: "อ่านหนังสือ",
    description:
        "อ่านหนังสือ Python ให้จบ 2 บท วันนี้ต้องเข้าใจเรื่อง OOP และการใช้ Decorators ใน Python เพื่อเตรียมทำโปรเจคต่อไป",
    success: true,
  ),
  TodoLists(
    title: "ทำโปรเจค Flutter",
    description:
        "เขียนหน้า Login ให้เสร็จ ต้องเพิ่มการตรวจสอบข้อมูล และทำให้รองรับการ Sign in ผ่าน Google ด้วย Firebase Auth",
    success: false,
  ),
  TodoLists(
    title: "นัดหมอฟัน",
    description:
        "โทรนัดหมายกับคลินิกทันตกรรมเพื่อขูดหินปูนและตรวจสุขภาพฟัน นัดวันพฤหัสบดีช่วงเย็นหลังเลิกงาน",
    success: true,
  ),
  TodoLists(
    title: "เรียนออนไลน์",
    description:
        "เข้าเรียนคอร์ส UI/UX Design วันนี้ต้องเรียนเรื่องหลักการออกแบบ Mobile App และทำแบบฝึกหัดออกแบบ Wireframe ให้เสร็จ",
    success: false,
  ),
  TodoLists(
    title: "ซักผ้า",
    description:
        "ซักเสื้อผ้า ผ้าปูที่นอน และผ้าขนหนู หลังจากนั้นต้องตากให้เรียบร้อย และพับเก็บเมื่อแห้งแล้ว",
    success: false,
  ),
  TodoLists(
    title: "ดูหนัง",
    description:
        "ดูหนัง Marvel เรื่องใหม่ที่เพิ่งเข้าโรงกับแฟน จองตั๋วแล้ว รอบฉาย 19:30 ที่โรง IMAX ควรไปก่อนเวลาสัก 20 นาทีเพื่อซื้อป๊อปคอร์น",
    success: true,
  ),
  TodoLists(
    title: "เขียนบทความ",
    description:
        "เขียน Blog เกี่ยวกับ Flutter และแชร์ประสบการณ์การพัฒนาแอปพลิเคชันด้วย Firebase พร้อมกับตัวอย่างโค้ดที่ใช้งานจริง",
    success: false,
  ),
];
