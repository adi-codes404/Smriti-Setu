import 'package:smriti_setu/features/archive/domain/memory_message.dart';

/// Pre-populated realistic sample voice messages for Smriti Setu demo archive.
const List<MemoryMessage> kDemoMemories = [
  MemoryMessage(
    id: 'mem-1',
    title: 'Diwali Blessings & Well Wishes',
    sender: 'Aarav',
    relationship: 'Grandson • Bengaluru',
    date: 'Today, 10:30 AM',
    duration: '0:42',
    preview:
        'Namaste Dadi! Wishing you a very happy and peaceful Diwali. We made your special recipe...',
    fullText:
        'Namaste Dadi! Wishing you a very happy and peaceful Diwali from Bengaluru. We made your favorite besan laddoos today using your special recipe, but they are never quite as sweet as yours. Everyone here is thinking of you and sending their love. I will call you on video tonight after puja!',
    isDemo: true,
  ),
  MemoryMessage(
    id: 'mem-2',
    title: 'Morning Health & Medicine Check',
    sender: 'Priya',
    relationship: 'Daughter • New Delhi',
    date: 'Yesterday, 8:15 AM',
    duration: '0:36',
    preview:
        'Namaste Ma, hope you had a restful sleep. Please remember to take your morning medicine...',
    fullText:
        'Namaste Ma, hope you had a restful sleep. Please remember to take your thyroid medicine before breakfast and drink enough lukewarm water today. The weather is getting cooler in Delhi now. Rahul sent his regards, and we are planning to visit you next weekend. Take care and eat your fruits!',
    isDemo: true,
  ),
  MemoryMessage(
    id: 'mem-3',
    title: 'Weekend Family Gathering & Visit',
    sender: 'Vikram',
    relationship: 'Son • Mumbai',
    date: '12 Oct 2026',
    duration: '1:05',
    preview:
        'Namaste Babuji, we have booked our train tickets and will arrive this Saturday morning...',
    fullText:
        'Namaste Babuji, we have booked our train tickets and will arrive this Saturday morning. Ananya has drawn a special picture for you and keeps asking how many days are left. We will spend the entire weekend together, and I will help you organize the garden as you wanted. Take rest until we get there!',
    isDemo: true,
  ),
  MemoryMessage(
    id: 'mem-4',
    title: 'Monsoon & Garden Update from Village',
    sender: 'Meera',
    relationship: 'Sister • Jaipur',
    date: '8 Oct 2026',
    duration: '0:50',
    preview:
        'Radhe Radhe! The courtyard jasmine that you planted is in full bloom and smells wonderful...',
    fullText:
        'Radhe Radhe! The rains have finally slowed down here and the courtyard jasmine that you planted is in full bloom. The whole veranda smells wonderful. Everyone in the mohalla was asking about your health yesterday. Take good care of your knees in this damp weather. Sending you heartfelt blessings.',
    isDemo: true,
  ),
];
