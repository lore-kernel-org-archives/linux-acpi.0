From: Christian Zoz <zoz-l3A5Bk7waGM@public.gmane.org>
Subject: Re: DSDT in initrd?
Date: Tue, 6 May 2003 08:42:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030506064222.GV1817@suse.de>
References: <Pine.LNX.4.53.0304282017540.1928@phoenix.kerstin.at> <20030504215051.GA488@elf.ucw.cz> <Pine.LNX.4.53.0305050829420.25721@dynast.gaugusch.at> <200305060007.49847.bob@diamond.demon.co.uk> <Pine.LNX.4.53.0305060743450.2529@tweety.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305060743450.2529-qopfHk9/S+VQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
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

On Tue, May 06, Markus Gaugusch wrote:
> On May 6, Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org> wrote:
> > Why use initrd?  Why not allow a file name to be passed to the kernel at
> > boot a la acpi=off, acpi=mydst.hex or whatever?  Put the file in the
> > /boot directory?
> I think that this is not possible. The filesystem would have to be
> accessible which is not the case at the early stage where ACPI loads
> (there could even be the case, that no interrupts are assigned yet, to use
> the scsi controller where the partition with the file is stored). Not to
> mention, that harddisk and scsi drivers are loaded much later anyway.
> The initrd is the only sane way to do this. I could also change my patch
> to accept a plain DSDT file, without my 'magic' signature, if no other
> initrd data is present.

Grub should be able to handle the file access at this stage.

-- 

ciao, christian

  --------------------------------------------------------------------
    Verglichen mit jedem x-beliebigen Redmonder Betriebssystem-Clone
    ist Linux geradezu eine leuchtende Perle der Datensicherheit.
  ------ Frank Rennemann (http://www.linux-knowledge-portal.org) -----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
