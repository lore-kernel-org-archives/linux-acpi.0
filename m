From: Andre Masella <andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org>
Subject: Vaio PGC-FXA47 Troubles
Date: Sun, 18 Aug 2002 23:02:00 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208182302.01068.andre@masella.dynodns.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I just got a Vaio FXA47 notebook and am having two seperate problems. I a=
m=20
running Gentoo with a Linux 2.4.19 kernel (from kernel.org -- not patched=
)=20
and acpid 1.0.1
The first is I cannot suspend the system. The /proc/acpi/sleep file conta=
ins=20
"S0 S3 S4 S5" but using 0, 4, or 5 powers off the system. 3 seems to susp=
end=20
it, but then it cannot be resumed. Is there a working suspend?
The /proc/acpi/battery/ directory is empty. There is a battery in the sys=
tem,=20
but it doesn't show up in that directory. What's wrong?
--=20
--Andre Masella (andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org)



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
