From: Christian Zoz <zoz-l3A5Bk7waGM@public.gmane.org>
Subject: Re: DSDT in initrd?
Date: Tue, 6 May 2003 06:05:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030506040532.GS1817@suse.de>
References: <Pine.LNX.4.53.0304282017540.1928@phoenix.kerstin.at> <20030504215051.GA488@elf.ucw.cz> <Pine.LNX.4.53.0305050829420.25721@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305050829420.25721-sxQ525G0OhRQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
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

On Mon, May 05, Markus Gaugusch wrote:
> > > Has anybody thought about putting the dsdt into the initial ramdisk?
> > > This would make changing/updating it much easier.
> > I guess initrd is too late to override it...
> If I would mount it, probably yes. But I rather thought about the way that
> bootsplash uses: Scan the initrd for a magic signature and read it 'raw'.
> The dsdt would not be in the filesystem of the initrd, but just appended
> to the compressed initrd. I think that something that is early enough for
> bootsplash should be early enough for the dsdt as well.

And this would make patching dsdt much easier for the unexperienced
user. Just download a file and call 'mkinitrd'.

If bootsplash is early enough, then lets do that.

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
