From: Ron Rechenmacher <ron@fnal.gov>
Subject: suspend/resume memory corruption on Dell Latitude D830 -- help please
Date: Mon, 14 Apr 2008 17:41:10 -0500
Message-ID: <4803DD86.9060105@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailgw2.fnal.gov ([131.225.111.12]:60468 "EHLO mailgw2.fnal.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276AbYDNXla (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 19:41:30 -0400
Received: from mailav2.fnal.gov (mailav2.fnal.gov [131.225.111.20])
 by mailgw2.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 with SMTP id <0JZC000ZS6YVZR@mailgw2.fnal.gov> for linux-acpi@vger.kernel.org;
 Mon, 14 Apr 2008 17:41:10 -0500 (CDT)
Received: from mailgw1.fnal.gov ([131.225.111.11])
 by mailav2.fnal.gov (SAVSMTP 3.1.7.47) with SMTP id M2008041417411025183 for
 <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2008 17:41:10 -0500
Received: from conversion-daemon.mailgw1.fnal.gov by mailgw1.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 id <0JZC00I016XATL@mailgw1.fnal.gov> (original mail from ron@fnal.gov)
 for linux-acpi@vger.kernel.org; Mon, 14 Apr 2008 17:41:10 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ron@fnal.gov

Hi,

Kernel: 2.6.24.3 x86_64
Apologizes in advance that I cannot start a bug report as I do not know 
how to reproduce this outside of nvidia/X :(

I've written a small test program which allocates memory, initializes it 
and prompts to "suspend/resume and press enter to verify".
When I suspend(to RAM, not disk)/resume and press enter, I sometimes see 
memory corruption. If the test does not see corruption, it free memory, 
reallocs,initializes and prompts. If the test see corruption it does not
free/realloc. It just reinitializes.  (code included at end)

So, when I see corruption, it is then re-corrupted in the same exact way 
every time I suspend/resume.

I've worked with Dell and have replace the memory, system board and 
processor.  So, I'm thinking there is a 99.99% probability that the 
problem is software (including BIOS).

For memory, I have 2 times 2 GB DIMMS and if both are installed,
I can run the same test under x86_64 linux and 32 bit vista and see the 
same exact corruption signature:
     2 16 bit values get corrupted:
         1 at offset 0x09a gets changed to 0x0047
         1 at offset 0x0a2 gets changed to 0x1200
(Actually the same exact address until I exist the test and start over.)
It appears the same physical page of memory is getting written to all 
the time.

So, it appears, so far, that the problem is not with Linux per se.

Some other facts:
   o  If I run with 2 GB under 32bit Vista the test seems to always pass.
   o  If I run with 2 GB under x86_64 Linux, I still get failures.
   o  There are a couple of other failure signatures, at least one of 
which is again, exactly the same on Vista as on Linux. This one happens 
much less often, but involves at least one contiguous chunk of 152 bytes 
being corrupted. (I can supply the pattern if anyone is interested.)

Here's where I need help... (As I do not now much about the real details 
of acpi suspend/resume)
Does, or is, the OS supposed to leave some memory alone for the acpi 
BIOS to use? Since the porblem happens with 2GB and x86_64 linux but not 
with 2GB and Vista, could there be a problem with Linux?
Is this obviously a Dell BIOS problem?
I'm wondering if there is nvidia BIOS involved?
What other tests can I do?  If I suspend/resume at the text console, I 
run into the blank video problem. (Is vbetool post,... the best/only way 
to re-init the video? The executable I have seems to have some 
problems.)  Can I safely ignore the blanked video and do testing for a 
serial console?  What else could it be?  Do both Linux and Vista have bugs?

What other info should I collect?

Apologies if the consensus is that this is not a linux-acpi devel issue 
:( -- but, I'm thinking that some people on this list have contacts with 
Dell BIOS people and if it is a Dell BIOS issue, this would (either way) 
be the most efficient way to get to real problem.

As a bit of background...
For the past 8 months, I've been getting intermittent crashes of the OS 
and/or applications.  I thought there was a problem with the HW so I did 
lots of tests, mainly Dell's diagnostics. But since the crashes seemed 
to most often happen shortly after resume (within a few seconds), I 
decided to try and suspend/resume during a memory test.  Dell's tests do 
not support this, so I had to come up with my own. I first was using 
"lucifer" http://www.ibiblio.org/pub/linux/utils/lucifer-1.0.tar.gz
but now I wrote my own (included below).

Please, any discussion or comments would be helpful.

Thanks,
Ron

The program I'm using:
#include <stdio.h>              /* printf */
#include <stdlib.h>             /* strtoul */
#include <unistd.h>             /* sleep */

#define USAGE "\
   usage: %s <mem_bytes>\n\
example: %s 11000000000\n\
", argv[0], argv[0]

#define MEM_VAL 0xdeadbeef

static void
bell( int bell_cnt )
{
     if (bell_cnt <= 0) return;
     printf("\007"); fflush(stdout);
     while (--bell_cnt)
     {   sleep(1);
         printf("\007"); fflush(stdout);
     }
     return;
}

int
main(  int      argc
      , char     *argv[] )
{
         long unsigned int       mem_bytes;
         long unsigned int       mem_dwords;
         long unsigned int       ii;
         unsigned int            *ptr;
         char                    buf[80];
         int                     error_found=0;

     if (argc <= 1) { printf( USAGE );exit(0); }

     mem_bytes = strtoul( argv[1], 0, 0 );
     printf( "testing %lu bytes\n", mem_bytes );
     mem_dwords = mem_bytes/4;
     printf( "testing %lu dwords (32bit)\n", mem_dwords );

     while (1)
     {
         if (!error_found) ptr = (unsigned int *)malloc( mem_dwords*4 );
         if (ptr == NULL)
         {   printf("malloc failed (too much mem?)\n"); exit(1);
         }

         printf( "initializing the mem..." ); fflush(stdout);
         for (ii=0; ii<mem_dwords; ii++) *(ptr+ii) = MEM_VAL;
         printf( " done\n" );

         printf( "susp/resume/press enter to test\n" ); bell(1);
         fgets( buf, sizeof(buf), stdin );

         printf( "verifying the mem..." ); fflush(stdout);
         for (ii=0; ii<mem_dwords; ii++)
         {   if (*(ptr+ii) != MEM_VAL)
             {   printf( "error at %p: found 0x%08x (should be 0x%08x)\n"
                        , ptr+ii, *(ptr+ii), MEM_VAL );
                 error_found = 1;
             }
         }
         printf( " done\n" );

         if (!error_found) { free( ptr ); ptr = 0; }
         else              bell(2);
     }
     return (0);
}   /* main */


