From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Resuming from S1 or S3 ...
Date: Thu, 3 Jul 2003 15:40:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030703134051.GT7796@poupinou.org>
References: <200307031328.20519.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200307031328.20519.hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 03, 2003 at 01:28:20PM +0200, Hrvoje Habjanic wrote:
> 
> Hi!
> 
> It's Compaq Armada M700 & 2.5.73 kernel. Suspending (S1) goes ok.
> 
> Waking up - that's another story. Initialy, laptop powers on, initialize 
> dislplay (i see text), and that's it (keyboard is dead). If i 
> connect/redirect console to serial port, i can work with everything in disk 
> cache (run lspci before suspend, and it is working afterwards also). Disk is 
> critical problem.
> 
> Using "lspci -xxx", i've detected that following hardware have different 
> config (comparing BEFORE & AFTER suspend):
> 1. Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
> 2. PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
> 3. IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> 4. USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
> 
> Using ".resume" in piix.c driver i've managed to fix 3 (IDE), and 4 can be 
> fixed in the same way (direct write to config space). Problem is 1 & 2. I 
> suspect that keyboard have same problem - IT ISN'T RESTORED AS IT SHOULD BE.
> 
> I cannot find place where ".resume" for host & pci bridge or keyboard is. Or 
> should i try another approach?
> 
> Is it posible to reinitialize ALL devices after resume? (so instead calling 
> poweron then resume, to call poweron then initialize then resume)
> 
> So, again, i'm stuck here. Keyboard is main problem here (i've fixed IDE), so 
> any suggestions? Where to go from here?

For keyboard controller, look if actually the mouse is the cause, especially
if it is multiplexed.  If yes, normally the keyboard controller should
go to legacy mode before resuming, then should restore multiplexing.

I have not checked if that is done yet, since apparently my system
do not have that issue.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
