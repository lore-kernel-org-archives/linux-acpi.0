From: tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org (Tomasz Ciolek)
Subject: Re: S3 suspend/resume driver questions
Date: Tue, 20 Apr 2004 13:25:40 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040420032540.GQ8823@dreamcraft.com.au>
References: <20040420025220.GA5577@dreamcraft.com.au> <GMail.1082430934.185927489.4271239555@brewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <GMail.1082430934.185927489.4271239555-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adrian Yee <brewt-acpi.sf.net-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 19, 2004 at 08:15:34PM -0700, Adrian Yee wrote:
> Hi,
> 
> > The symptoms of bad S3 state on the P2120 is that after a resume the
> > laptop does NOT redo the Radeon M6 post correctly (at all) as a
> > consequence the screen remils blank (off) and no video/console... 
> 
> Have you tried the things mentioned in Documentation/power/video.txt?  I had to do acpi_sleep=s3_bios to get video working on my system.
> 
> Adrian

yes. I have tried that. Im assuming thats a kernel boot option?

TMC

-- 
Tomasz M. Ciolek	
*******************************************************************************
 tmc at dreamcraft dot com dot au 
*******************************************************************************
   GPG Key ID:		0x41C4C2F0
   GPG Key Fingerprint: 3883 B308 8256 2246 D3ED  A1FF 3A1D 0EAD 41C4 C2F0
   Key available on www.pgp.net	
*******************************************************************************


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
