From: Florian =?ISO-8859-15?Q?H=FChn?= <acpi-14TN6mYQPXr1AXQ8ov2VOh2eb7JE58TQ@public.gmane.org>
Subject: Re: proper enabling of AMD K7 power saving
Date: Tue, 15 Jun 2004 00:37:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040615003730.051ec41e.acpi@trafficmanager.org>
References: <200406142311.54120.malte.gell@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200406142311.54120.malte.gell-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 14 Jun 2004 23:11:53 +0200
Malte Gell <malte.gell-Mmb7MZpHnFY@public.gmane.org> wrote:

> Hi,
> 
> i have an AMD Duron 750 desktop computer with Via KT133a chipset and to 
> get some noticeable temperature decrease I need to invoke a command 
> from the Athlon Powersaving Howto for this chipset
> (http://www.tldp.org/HOWTO/Athlon-Powersaving-HOWTO/
> approaches.html#commandline )
> 
> Is it right that it is the fault of the mainboard manufacturer if one 
> has to invoke such a command to get C2-level for power saving?

Yes.

> 
> Will Linux-ACPI one day address this problem so a user doesn't need to 
> invoke something like "setpci -v -H1 -s 0:0.0 52=$(printf %x $((0x
> $(setpci -H1 -s 0:0.0 52) | 0x80)))" to enable proper power saving?

Have a look at http://vcool.occludo.net/VC_Linux.html or try the kernelpatch
on the page you mentioned. It runs great for several years now on my desktop
pc. On http://vcool.occludo.net/VC_Theory.html there is a short explanation
how it works and what it is.

> 
> My fear is just one day I buy a new mainboard and there's no appropriate 
> setpci-command on the Powersaving Howto and Linux-ACPI doesn't enable 
> C2-powersaving if the mainboard doesn't do it first... 

Don't panic. The address of the register in the north/southbridge will always
be known. At least i hope so ;)

> 
> Why the f*** do mainboard makers not offer a BIOS switch to enable this?

Some ppl say it's because some early athlos had problems with powersaving.
In fact i have never seen or heared about such a system. (I by myself tested
about 20 or 25 computers, all worked as expected.) I really can't imagine why
they don't enable it by default like all the Laptop-BIOSes does.

> Besides the lack of out-of-the-box C2-level ACPI just runs fine. I 
> guess if new generation mainboards (KT400 and up) would better handle 
> K7 power saving we wouldn't need the Powersaving Howto, right?
> 
> regards
> Malte
> 
> (SuSE 9.0,Linux 2.4.21+ACPI 20030619 on Elitegroup K7VZA Rev3.0 + AMD 
> Duron 750 (old spitfire core))

Sorry for my bad english.

PS: eh... gmx.DE? Warum zum Teufel schreib ich das auf englisch?! Damn.


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
