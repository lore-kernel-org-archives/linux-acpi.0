From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: Acer Travermate 8005 and battery info
Date: Thu, 7 Oct 2004 15:41:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041007134121.GB534@openzaurus.ucw.cz>
References: <415C270F.5050306@lanil.mine.nu> <20041001102926.GD18786@elf.ucw.cz> <415D8CCF.8050602@lanil.mine.nu> <20041001194739.GE1100@openzaurus.ucw.cz> <41603BA0.9090900@lanil.mine.nu> <20041003203457.GD3379@elf.ucw.cz> <41617104.2040302@mega.ist.utl.pt> <20041005143951.GB4723@openzaurus.ucw.cz> <4162C0D1.20906@mega.ist.utl.pt> <20041006134610.2f310f7e.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041006134610.2f310f7e.vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > i'll start studying i2c to find out the smbus "address" (sorry if this 
> > is a dumb mistake) and try to scan it for the smart battery.
> 
> Some code already exists - the lm_sensors package
> (http://secure.netroedge.com/~lm78/) includes the "smartbatt" module.
> However, it is for 2.4.x kernels, therefore some porting work will be
> needed to use it on 2.6.x.

Parts of lm_sensors were merged to 2.6.X, already. If code is clean enough,
chances of inclusion into mainline are quite good...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
