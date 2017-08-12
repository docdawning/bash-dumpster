This abomination is a by-product of my screwing around with a ravaged LVM-backed filesystem.

Long ago I used to store heaps of crap on a striped LVM. Knowing full well one day I'd lose a disk
and then I would be sad. So I at least scripted rsync backups of the seriously important data. The 
less important stuff hung out there, waiting for the enevitable.

Over the years, my LVM went through many disk changes. It was in service for about 12 years without
a single failure and with all original drives replaced along the way. I eventually spawned a
new LVM (I wanted to get away from ReiserFS and just use ext4). The new LVM lived only across 3 drives,
rather than a peak of 7 drives in the original faithful setup. After about two years on the new LVM,
two of my drives, both the cheapest possible Seagate ones, died.

I managed to get most of one of the drives using DD rescue. I dumped its contents to a file on a new
massive drive. The other drive I only got a tiny bit of. I tried various repair efforts including 
replacing the drive's PCB. But then like a n00b I managed to ruin a pin on the controller's ROM.
I guess I could have tried a platter transplant. But you see, I'm actually kind of busy and I shelved
the recovery for some years. So now I have a really massive nice drive sitting with the partially 
recovered raw data. I decided this is it, I'm going to dig in and get what I can. After that,
I'm repurposing the remaining good LVM related gear.

I'm mainly following this guide: https://www.novell.com/coolsolutions/appnote/19386.html

Once I got the LVM itself to function again, the file system needed great attention. I quickly
found running fsck on a large volume needs heaps of RAM. Sure there's a technique for making
fsck run using minimal RAM, but I decided that since each run of fsck would end by running out of memory
I could keep running it and eventually reach my destination, since each run was changing the file system.

So, I decided to write this crappy script. It just keeps running fsck until the return code is zero.
Like a little kid baggering their parents to death. Hopefully this will end with SOME of the recovered
~4TB of data being actually readable. I suspect I'll only really get more like 1.5TB. Whatever, like
I said, I moved on years ago and had backups for the stuff I really cared about. So this is more
academic than anything.

-James T Snell, the last
