# EduID – Education & Career Path Platform

EduID is a mobile-first education platform designed for Sri Lankan students (Grades 1–13) that connects students with teachers, tracks learning progress, and builds a foundation for career readiness. The platform provides a modern, interactive, and motivational learning experience while planning for professional development and certificates.

---

## Table of Contents

- [Key Features (Phase 1 – MVP)](#key-features-phase-1--mvp)
  - [Student Features](#student-features)
  - [Teacher Features](#teacher-features)
  - [Universal Features](#universal-features)
- [Future Enhancements](#future-enhancements)
- [Tech Stack](#tech-stack)
- [UI/UX Guidelines](#uiux-guidelines)
- [Project Vision](#project-vision)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)
- [Contact](#contact)

---

## Key Features (Phase 1 – MVP)

### Student Features

- **Personalized Home Dashboard**: Greetings, progress, and motivational messages.
- **Exam & Essay Submission**: Upload essays or assignments for teacher grading.
- **Results & Feedback**: View grades, teacher comments, and downloadable feedback.
- **Notifications**: Alerts for upcoming exams, feedback ready, and deadlines.
- **Profile Page**: Manage student profile and subscription info (future).

### Teacher Features

- **Dashboard Overview**: Pending essays, graded assignments, and flagged submissions.
- **Essay Review & Grading**: Assign marks and comments efficiently.
- **Class Management**: Add students to classes, organize subjects (future).
- **Notifications**: Stay updated with submissions and deadlines.

### Universal Features

- **Authentication**: Login, Signup, Forgot/Reset Password.
- **Role-Based Access**: Student / Teacher.
- **Responsive Design**: Works on mobile and tablets with Flutter.

---

## Future Enhancements

- Online classrooms (video/live sessions)
- Gamification: Top 10 student rewards per grade
- Career path guidance for HR screening
- Certificate management for courses, diplomas, degrees
- Multi-language support (Sinhala, Tamil, English)
- Subscription marketplace with subjects and teacher reviews

---

## Tech Stack

**Mobile App:**  
- Flutter (iOS & Android)  
- Riverpod/BLoC, Dio for networking  
- Hive/SharedPreferences for local storage  
- Material 3 UI

**Web Dashboard:**  
- React + Vite/Next.js  
- TailwindCSS  
- Redux/Zustand  
- Recharts/Chart.js

**Backend:**  
- Node.js + NestJS  
- JWT/Firebase Auth  
- PostgreSQL  
- AWS S3/Firebase Storage  
- FCM/SendGrid/Twilio for notifications

**DevOps:**  
- Vercel/Firebase/Render hosting  
- GitHub Actions for CI/CD

---

## UI/UX Guidelines

- **Fonts:** Headings → Merriweather, Body → Open Sans
- **Colors:**  
  - Primary Blue: `#1E3A8A`  
  - Secondary Green: `#22C55E`  
  - Accent Orange: `#F59E0B`
- **Icons:** Feather Icons / Material Icons
- **Animations:** Subtle micro-interactions (button ripples, card lifts, streak flames)

---

## Project Vision

EduID aims to be the essential education app for Sri Lankan students.

- **Phase 1:** Core student-teacher interaction (essays, grading, feedback).
- **Phase 2+:** Courses, certificates, career guidance, and gamification.
- **Long-term:** Expand to other countries while maintaining an intuitive, educational-first experience.

---

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) and npm/yarn
- [Flutter](https://flutter.dev/docs/get-started/install) (for mobile development)
- [PostgreSQL](https://www.postgresql.org/download/)
- [Firebase](https://firebase.google.com/), AWS S3, or relevant backend services accounts

### Installation

```bash
# Clone the repository
git clone https://github.com/Vheshan37/edu_id.git
cd edu_id

# Install dependencies for mobile app
cd mobile
flutter pub get

# Install dependencies for web dashboard
cd ../web
npm install

# Install backend dependencies
cd ../backend
npm install
```

### Usage

- Start the backend server:
  ```bash
  cd backend
  npm run start
  ```
- Run the mobile app:
  ```bash
  cd ../mobile
  flutter run
  ```
- Launch the web dashboard:
  ```bash
  cd ../web
  npm run dev
  ```
- Configure environment variables as needed (see `.env.example`).

---

## Contributing

Contributions are welcome!  
Please read the [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## License

Distributed under the [MIT License](LICENSE).  
See the `LICENSE` file for more information.

---

## Acknowledgements

- Feather Icons, Material Icons
- Flutter and React open-source communities
- All contributors and early testers

---

## Contact

Project Link: [https://github.com/Vheshan37/edu_id](https://github.com/Vheshan37/edu_id)  
Maintainer: [@Vheshan37](https://github.com/Vheshan37)
