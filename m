From: valvoline <valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Subject: Re: ACPI and APM
Date: Sun, 25 Aug 2002 12:00:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020825120053.4241be9e.valvoline@tiscalinet.it>
References: <20020824192026.0e4811bf.valvoline@tiscalinet.it>
	<20020824205341.GA4124@delight>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020824205341.GA4124-xRkoNhv+aXY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 24 Aug 2002 22:53:41 +0200
anders-VYFdHW3tBKJknbxzx/v8hQ@public.gmane.org wrote:

> As far as I know if you enable both acpi and apm it just uses apm, it will
> even tell you during boot (dmesg please). I don't know what you hacked

i've uploaded a patch for 2.4.19 with both my modding and the official 20020821-2.4.19.patch,
you have to patch a clean 2.4.19 kernel to make it works. with this modding, the kernel skip
the apm & acpi check during boot, and will map/load both apm and acpi system management.

you can download the patch from this url: http://www.vrlteam.org/patch-apm_acpi_010.tgz

> (since you didn't include a patch) but it just seems as if suspend works
> with apm and not acpi, like it does with my toshiba.

yep. it's true. but since acpi support is not 100% completed, and since apm support lacks of
many features, i'm trying to use both to obtain a 99.9% featured box...so, i'll use
fans and thermal zone from ACPI; battery and sleep states from APM.

-- 
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
