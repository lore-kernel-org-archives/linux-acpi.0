From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: Re: Compaq Armada 1500c
Date: Mon, 7 Apr 2003 12:52:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F12EC61@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Schilhabel <florian.schilhabel-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Florian!

I have a Compaq Armada E500 which is a little bit newer than your model =
and it works fairly well with ACPI (troubles to resume from suspend). =
You have to patch the DSDT to get the thermal zone to work properly. =
Disassemble your built in DSDT, delete the star from all *PNP... names =
and try to compile it again. Usually their are a few further errors but =
they are easy to correct (incorrect return values and such things). =
After this trial and error phase, patch your linux kernel to override =
the DSDT and your are ready.
Compaq has a strange naming policy in their DSDT. They patch all ACPI =
Symbols into names of the form C### (starting from C000). By inspecting =
/proc/acpi/... you get hints which of these symbols represents =
batteries, fans, cpu's and such things. I have patched my DSDT to =
contain better names for user visible things, you can get my patched =
DSDT from

   =
http://agcad.ict.tuwien.ac.at/linux-patches/compaq-armada-e500-dsdt.tar.g=
z=20

What I know from earlier Compaq Notebooks is that they work really well =
with apm. I think, you would be more pleased with Linux on your hardware =
if you use apm. In fact, suspend to ram should work better on the older =
Compaq machines.

Hope this helps,
Herbert.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
