From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: best acpi solution
Date: Wed, 21 May 2003 17:44:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030521154428.GZ346@poupinou.org>
References: <3ECB3CE2.5000400@ottaky.com> <01db01c31f90$84ae6840$3746028e@bio.dfo.ca> <3ECB8ADF.5020108@ottaky.com> <20030521142117.GX346@poupinou.org> <3ECB9BB8.9070700@ottaky.com> <20030521150233.GY346@poupinou.org> <3ECBA777.9090100@ottaky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ECBA777.9090100-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, May 21, 2003 at 04:21:11PM +0000, sjb wrote:
> Ducrot Bruno wrote:
> 
> >I meant the latest 2.4 ac tree (not 2.5) because tt has
> >recent acpi and cpufreq (for longrun) and therefore no need
> >to apply 2 patches.
> 
> Another dumb question .. where would I find that?
> 
> Is it a question of running these patahces
> 
> http://www.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.21/patch-2.4.21-rc2-ac2.gz
> 
> against the corresponding 2.4.21 kernel?

yes and no.  2.4.21 is not out AFAIK.


Grab (well, I prefer ftp):

ftp://ftp.kernel.org/pub/linux/kernel/v2.4/linux-2.4.20.tar.bz2
ftp://ftp.kernel.org/pub/linux/kernel/v2.4/testing/patch-2.4.21-rc2.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.21/patch-2.4.21-rc2-ac2.bz2

Then, for example in your home directory:

tar xjvfp linux-2.4.20.tar.bz2
or tar xIvfp linux-2.4.20.tar.bz2 since the j vs I option is alas dependant of
the distribution.  You may want if that do not work to
bzip2 linux-2.4.20.tar.bz2 | tar xvfp -
instead.

Then you will have a newly linux-2.4.20 directory.
First, move it so that it correspond to the wanted version:
cp linux-2.4.20 linux-2.4.21-rc2-ac2

then go to this directory, then do something like that (in order):
bzip2 /path/to/patch-2.4.21-rc2.bz2 | patch -p1
bzip2 /patth/to/patch-2.4.21-rc2-ac2.bz2 | patch -p1

(you may also want to
bzip2 /path/to/thispatch.diff.bz2 | patch -p1 2>&1 | tee ../patch.log
if you want to check in the file ../patch.log if all is OK (but
the patch-2.4.21-rc2.bz2 and the ac2 corresponding are always
clean anyway).


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
