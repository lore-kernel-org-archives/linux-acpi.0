From: Julien Lerouge <julien.lerouge-GANU6spQydw@public.gmane.org>
Subject: Re: Asus ACPI Hotkeys
Date: Sat, 17 May 2003 21:32:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030517193221.GA429@babar.linux.home>
References: <F760B14C9561B941B89469F59BA3A84725A2A6@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2A6-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>, Gertjan <g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 16, 2003 at 03:37:02PM -0700, Grover, Andrew wrote:
> > From: Karol Kozimor [mailto:sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org] 
> > Thus wrote Grover, Andrew:
> > > Well then probably someone needs to write a device driver 
> > for this, just
> > > like for Toshiba's special device.
> > 
> > Actually, it has already been done. Right now, we're working 
> > with Julien to 
> > simplify the code and to add some features. The code is now 
> > under heavy 
> > re-development, and we'll make an appropriate announce once 
> > it becomes 
> > stable enough.
> > 
> > Since we were aiming at merging the driver with the ACPI code 
> > (more or less
> > on the same basis the Toshiba driver is) anyway, we can as 
> > well ask right
> > now, whether this would be possible somewhere in the future? 

> Of course! This is exactly what I was hoping for.

> Regards -- Andy


Well, here is a new version of the driver. It was tested against
2.4.21-rc2 + acpi-20030512-2.4.21-rc2.diff

Any comment welcome

http://julien.lerouge.free.fr/sources/asus_acpi-0.20.tar.bz2

-- 
Prédire n'est pas expliquer.
		-- Thom, René


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
