From: "Florian Schilhabel" <florian.schilhabel-S0/GAf8tV78@public.gmane.org>
Subject: Compaq Armada 1500c
Date: Fri, 4 Apr 2003 18:15:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304041615.h34GFZq12406@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi there,

last week i got an old ( new for me ;-) ) laptop - Compaq Armada 1500c with an preinstalled Win98... *spew*
first of all, i replaced this piece of software with a real OS...( successfully, of course )
except one thing ;-(( - everybody can imagine now, what happened:
when i first started the laptop, the fan started ( with win98 )
now it's over - guess its the famous ACPI description table...
my question is:

has anybody a working table for this laptop???
next question:
in thermal_zone there are some weird entries:
cat trip_points gives my the following:

critical       95 C
passive      94 C
active[0]     84 C
active[1]     72 C

i belive, there must be something wrong here...
even if the temperature ( cat temperature ) goes over 72 C, the fan is still inactive...., too bad
is this a bug ???

if anyone could help me, - would be nice...

greetz
flo
______________________________________________________________________________
UNICEF bittet um Spenden fur die Kinder im Irak! Hier online an
UNICEF spenden: https://spenden.web.de/unicef/special/?mc=021101



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
