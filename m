From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: DSDT in initrd?
Date: Tue, 6 May 2003 10:17:48 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305061011100.11312@dynast.gaugusch.at>
References: <Pine.LNX.4.53.0304282017540.1928@phoenix.kerstin.at>
 <20030504215051.GA488@elf.ucw.cz> <Pine.LNX.4.53.0305050829420.25721@dynast.gaugusch.at>
 <200305060007.49847.bob@diamond.demon.co.uk> <Pine.LNX.4.53.0305060743450.2529@tweety.gaugusch.at>
 <871xzcts6v.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <871xzcts6v.fsf-E1YXmAG8v4VQD7NkSvH8p9BPR1lH4CV8@public.gmane.org>
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

On May 6, Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org> wrote:
> Or make the acpi=file.hex boot argument refer to a file within the
> initrd image. Then its just a case of getting mkinitrd patched to look
> for /boot/dsdt.hex by default, and letting the user specificy an
> alternate DSDT by parameter and generating initrd's would be a simple.
I don't have the knowledge (yet) to mount the initrd. Usually, it is
mounted after everything is initialised, but not at the early stage where
ACPI is loaded. I don't even know if any filesystem drivers are present at
this stage.

Markus

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
