From: "Derek Broughton" <derek_broughton-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: lid state?
Date: Mon, 7 Oct 2002 09:10:38 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OE13CngokVNTmgEVg3U0000c5a1@hotmail.com>
References: <3D9FC692.6050005@prairienet.org>
Reply-To: "Derek Broughton" <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: "John Belmonte" <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
>
> What is the correct way to detect the lid state on a lid event?  I've
> seen some mention of using a counter, but as the lid could be closed
> before acpid starts up, it doesn't seem very robust.

It's far from ideal, but it's robust enough, because the lid state bears no
connection to acpid.  Whether or not acpid is running, events get generated.
I suppose, conceivably, the lid could be closed when the system boots and
ACPI starts - but how realistic is that?  I can't see it happening on my
system.
--
derek


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
