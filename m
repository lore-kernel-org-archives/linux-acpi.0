From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Questions about vbestate
Date: Tue, 18 Jan 2005 19:12:19 +0100
Message-ID: <200501181912.19644.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
I am still investigating the suspend-to-ram issues with the radeon graphic 
cards. I am trying to get s3 working with the proprietary  fglrx driver from 
ati.

There is no problem with the kernel module, but switching back to the X server 
after resuming and post-ing the card the driver hangs. Bad so far. I 
investigated a little bit more:

*switching to the console(no framebuffer), posting the card with one of the 
c000:3 callers and switching back to X causes a crash

*If I save the card's state with vbesate before calling the post-routine and 
restoring the state afterwards makes switching back to X work again.

*BUT: If I switch to the console, save the state, go to suspend, wake up the 
system and restore the vbestate fglrx crashes again.

So my question is: Are there some settings which might get lost during and S3 
which are NOT restored by vbestate?

I am using fglrx V.8.8.25 with X.Org 6.8.1. I will also write a mail to ATI to 
help them fix their driver. They say that they are aware of this problem and 
haven't found a solution yet.

Note: S3 works fine for me with the gpl "radeon" driver from X.Org. I am 
trying to get fglrx working because I need it for gaming and I don't want to 
switch the konfiguration permanently. It would also help users with a radeon 
>=9200 card.

Cheers,
Stefan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
