From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: 2.6.0-test4 acpi problems
Date: Sun, 31 Aug 2003 11:38:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200308311138.03604.adq_dvb@lidskialf.net>
References: <20030830215116.GA1444@rootdir.de> <200308310219.41304.adq_dvb@lidskialf.net> <20030831003536.GG14307@sal.chbm.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030831003536.GG14307-hpVnRXGo/2ksCylrc8G9yg@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carlos Morgado <chbm-acpi-NoC/J83UA1I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 31 August 2003 01:35, Carlos Morgado wrote:
> On Sun, 31 Aug 2003 02:19:41, Andrew de Quincey wrote:
> > Aha, this is a known problem with the KT400 chipset. All BIOSes I've
> > encountered for the KT400 have a nasty bug in the AML code which breaks
> > ACPI IRQ routing.
>
> As far as I can tell my asus a7v8x only doesn't enumerate the ide irqs.

Can you send me a complete dmesg from a failed boot please? Also, an lspci 
-vvv, and /proc/acpi/dsdt from a successful boot.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
