From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Need for an ACPI webpage
Date: Fri, 18 Oct 2002 00:20:39 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210180020.39135.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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

Until now I have hust been lurking in this list. 
I realized now that I may need to patch my DSDT and found out that:
- I cannot find any web-page with a list of known/buggy/patched systems, where 
we could share knowledge on a *per system* basis. I can only lurk the list 
for previous discussions etc.
Never mind about my own system, this should apply to all..

I propose that we construct a table like: (example)
System		kernel/ACPI		State		More
------------------------------------------------
HP Xe3GC	all			DSDT		Patch with <a href...> the patch </a>
		2.4.20/20020918		tested-OK	No suspend
		2.5.29-/-		buggy		No sleep resume, hang on kbd
		2.5.33+/20021002	unknown		Sleep fixed, rest?
Asus M2000E	2.5.40			bug		hangs.. (some_name-cx69T0KZIJYAvxtiuMwx3w@public.gmane.org)
Foobar(TM)	all			horrible		Don't use!

---------------------

... and put it in an official page, where all can see it.

I believe that DSDT's need only be fixed once, so that would be a useful place 
to put them in. 

We could all contribute there, by treating the table as a project. Each time 
we mention sth useful in the list, we could make sure it is transferred 
there.

Regards
P. Christeas



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
