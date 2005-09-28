From: vidyut karan <kvidyut2000-/E1597aS9LQxFYw1CcD5bw@public.gmane.org>
Subject: problem in allocating resources for
Date: Wed, 28 Sep 2005 15:08:14 +0100 (BST)
Message-ID: <20050928140814.28476.qmail@web35410.mail.mud.yahoo.com>
References: <20050926100312.B3471@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1915766002-1127916494=:28226"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050926100312.B3471-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-hotplug-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--0-1915766002-1127916494=:28226
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,
While inserting pciehp.ko module(for native hot plug PCI Express support,=
 ACPI enabled), the following messages appear:
"pciehp: pciehp: controller initialization failed".
Can somebody give me some pointers where the problem possibly lies.
Also on looking at the debug messages,=20
acpi_parse_crs function (add_host_bridge --> acpi_get_crs --> acpi_parse_=
crs) prints only the following msg:

"pciehp: End_tag -------- Resource" is printed.

=20

kindly give me some pointers to identify the cause of problem

=20

thanks,

karan


	=09
---------------------------------
 Yahoo! India Matrimony: Find your partner now.
--0-1915766002-1127916494=:28226
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<DIV>Hi all,</DIV>
<DIV>While inserting pciehp.ko module(for native hot plug PCI Express sup=
port, ACPI enabled), the following messages appear:</DIV>
<DIV><EM>"pciehp: pciehp: controller initialization failed".</EM></DIV>
<DIV>Can somebody give me some pointers where the problem possibly lies.<=
/DIV>
<DIV>Also on looking at the debug messages, </DIV>
<DIV>acpi_parse_crs function (add_host_bridge --&gt; acpi_get_crs --&gt; =
acpi_parse_crs) prints only the following msg:</DIV>
<DIV><FONT size=3D2>
<P><EM>"pciehp: End_tag -------- Resource" </EM>is printed.</P>
<P>&nbsp;</P>
<P>kindly give me some pointers to identify the cause of problem</P>
<P>&nbsp;</P>
<P>thanks,</P>
<P>karan</FONT></P></DIV><p>
		<hr size=3D1>=20
<a href=3Dhttp://yahoo.shaadi.com>Yahoo! India Matrimony</a href>: Find y=
our partner now.
--0-1915766002-1127916494=:28226--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
