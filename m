From: Pere =?ISO-8859-1?Q?Casta=F1er_Sard=E0?= <XaRz69-pCzzcW6XgXY@public.gmane.org>
Subject: Re: new DRI resume binary snapshots and patches available
Date: 04 Dec 2002 20:41:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039030887.15651.11.camel@debian.Debian-beast>
References: <20021203232507.GA1723@dutidad.twi.tudelft.nl>
	 <1039010406.31730.53.camel@debian.Debian-beast>
	 <1039011070.4773.36.camel@dutidad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1039011070.4773.36.camel-1Jw6Eky0yc0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpidevel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

El mié, 04-12-2002 a las 15:11, Charl P. Botha escribió:

> There should be no problem... it's exactly the same as the dri.sf.net
> binaries, except that it has my patch integrated and installs its own
> copy of the XFree86, libxaa.a and libpcidata.a binaries as well.  These
> have all been built from a 20021203 checkout of the DRI tree.
mmm it won't install. This is the output:

Begin-----------------------------------------------------
DIRECT RENDERING OPEN SOURCE PROJECT  -  DRIVER INSTALLATION SCRIPT

[ http://dri.sourceforge.net ]

==========================================================================

The script will now compile the DRM kernel modules for your machine.

Press ENTER to continue or CTRL-C to exit.


Compiling...
ERROR: Kernel modules did not compile

The DRI drivers can not be installed without the latest kernel modules.
Installation will be aborted. See the dri.log file for information on
what went wrong.
-------------------------------------------------------end

> ps. You know about the SSE problems in current DRI?  If some of your
> applications quit with a FPE, start them with env var MESA_NO_SSE=1 ...
> this bug manifested after the latest Mesa merge.

Uh! I don't knew nothing about it. But I 've not see nothing strange in
my 3D apps (quake3 mostly).But thanks for the comment.

PD: I haven't be able to install swsusp(beta16)-vainilla
+acpi20021126-2.4.20-rc3.diff with linux-2.4.20 final release of the
kernel, and because of this, your resume-patch doesn't have any sense
for my hardware (at this moment).



-- 
Pere Castañer Sardà
Computer Management Technical Engineering Student on UOC
Member of AEIGi (http://www.aeigi.org)
Linux Registered User #232073 
Debian/GNU User (http://www.debian.org)



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
