From: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Subject: Re: 2.5.69 - S3
Date: Mon, 19 May 2003 18:22:13 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305191817.27962.mflt1@micrologica.com.hk>
References: <200305140140.02188.mflt1@micrologica.com.hk> <200305191731.34692.mflt1@micrologica.com.hk> <20030519100135.GA18034@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030519100135.GA18034-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 19 May 2003 18:01, Pavel Machek wrote:

> > Cant' apply the patch to either 2.5.69 vanilla and -bk as of
> > yesterday (mtrr/main.c unchanged anyway).
>
> I told you so ;-).
>

Sorry, I patch first and ask later !-( 

When will this go into mainline?

> > Why does one have to enable CONFIG_SOFTWARE_SUSPEND to enable
> > option for ACPI sleep states (CONFIG_ACPI_SLEEP)?
>
> It shares refrigerator etc. If you want to separate them... I guess
> people would welcome that.

What about making refrigerator independent of both - somewhat as a kernel facility?

BTW, Karol mentioned that S3 seems to have broken recently. What kernel version were these big IDE changes?

Regards
Michael




-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
