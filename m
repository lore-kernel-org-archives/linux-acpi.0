From: maximE bizon <maximE.bizon-ZrNlpQwM5lQ@public.gmane.org>
Subject: Re: Bitfield usage in FADT table?
Date: Tue, 11 Nov 2003 19:25:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031111182522.GA19215@dabelg.epita.fr>
References: <20031111161527.GC23128@sh.epita.fr> <20031111170245.GE29175@poupinou.org> <20031111171845.GA19024@dabelg.epita.fr> <20031111175730.GG29175@poupinou.org>
Reply-To: max-ZrNlpQwM5lQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031111175730.GG29175-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Tue, Nov 11, 2003 at 06:57:30PM +0100, Ducrot Bruno wrote:

> You also forgot to answer to my second question:
> 
> What you want to do, exactly?

I own a Latitude X200 notebook, with kernel 2.6.0-test9 installed, and
S3 doesn't work.  It was posted here a few days  ago.  S3 does suspend
the computer but it is impossible to turn it on again.

I  noticed that  my power  button  is detected  as a  FF because  FADT
pwr_button flag is not set, though the DSDT defines one.

I suspected the S3 problem to come from this, so I tried to correct my
FADT, but I forgot that the bitfield was on u32...

Now with  the correct fix, I  can see an  acpi event when I  press the
power button, but the system still won't come up after an S3.

Any idea ?

-- 
Maxime


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
