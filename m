From: Martijn van de Streek <martijn-Qnkk5oMnPFw@public.gmane.org>
Subject: Re: lid state?
Date: Mon, 7 Oct 2002 16:11:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021007141136.GA26168@o2w.nl>
References: <3D9FC692.6050005@prairienet.org> <OE13CngokVNTmgEVg3U0000c5a1@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OE13CngokVNTmgEVg3U0000c5a1-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Cc: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 07 Oct 2002, Derek Broughton wrote:

> It's far from ideal, but it's robust enough, because the lid state bears no
> connection to acpid.  Whether or not acpid is running, events get generated.
> I suppose, conceivably, the lid could be closed when the system boots and
> ACPI starts - but how realistic is that?  I can't see it happening on my
> system.

It's very well possible to do that. And it breaks any on/off type script
you set up for the lid button.

I'd like separate open and close messages as well actually..

Martijn
-- 
You may be infinitely smaller than some things, but you're infinitely 
larger than others.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
