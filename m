From: Isaac Chanin <chanin-bQtQpA3LQaY@public.gmane.org>
Subject: A few ACPI questions
Date: Thu, 24 Feb 2005 22:50:20 -0500
Message-ID: <421EA07C.1060507@wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I've a few questions about some ACPI issues, but first some specs would 
probably be helpful.  The computer that I'm using is a Mitac 8355 laptop 
with an Athlon64 3200+ running a 2.6.10 kernel.  For lspci see 
http://users.wpi.edu/~chanin/acpi/lspci.

The first question is about the dsdt (which you can view - well, you can 
view my slightly edited version, just fixed the obvious things - at 
http://users.wpi.edu/~chanin/acpi/dsdt.dsl), there's a 'function' (if it 
can be called that) at line 1756.  It's supposed to always return 
something but  does not always do so.  I looked around and I've seen 
some people making it return 0 at the end, 1 at the end, TMD0 at the 
end, and 1 at the beginning.  So I really had no idea precisely what fix 
would be appropriate.  Or - does it not even matter?  It is just a 
warning after all, and IDE transfers seem to be working fine (in 
conjunction with ACPI perhaps less so, but that's neither here nor there.)

The other thing of note with the dsdt is around line 772 where it sets 
OSFG based on what it was set to before and the length of the operating 
system's name.  I've tried changing the OS name to match the lengths 
given with no changes in anything pretty much.  Looking through the file 
I do not even see where OSFG is ever accessed.  Just figured it might 
matter too, as it is a small anomaly.

The more noticeable problem that I'm having is with sleep states. 
Standby seems closer to working than S3, but I'm not so sure.  Upon 
switching to standby the screen will flash back and then turn right back 
on.  The following is logged:

Feb 24 22:14:37 laptop Stopping tasks: 
======================================================|
Feb 24 22:14:37 laptop Restarting tasks... done

S3/Mem causes a kernel panic, and I'm currently trying kernel's with 
less stuff and/or newer kernels to see if I can get it to do something 
more useful.

So any recommendations on what I should do with the dsdt?  Or any next 
steps for fixing sleep states, I've already tried everything in 
tricks.txt and the other documentation, although informative, wasn't 
incredibly practical for my siltation.

Thanks,
Isaac


P.S. For any replies could you cc the message to me too please - I made 
an attempt at joining the list, but couldn't get a confirmation of my 
confirmation e-mail, so I'm not 100% sure that I'm joined yet.  Thanks 
again.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
