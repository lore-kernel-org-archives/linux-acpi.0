From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Pushing ACPI to 2.4.20?
Date: Wed, 25 Sep 2002 12:37:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020925123740.A25721@parcelfarce.linux.theplanet.co.uk>
References: <3D90E44B.2030400@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D90E44B.2030400-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>; from ahaning-mn4gwa5WIIQysxA8WJXlww@public.gmane.org on Tue, Sep 24, 2002 at 10:16:43PM +0000
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ahaning-mn4gwa5WIIQysxA8WJXlww@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2002 at 10:16:43PM +0000, ahaning-mn4gwa5WIIQysxA8WJXlww@public.gmane.org wrote:
> Shouldn't I be able to at least suspend my machine to RAM and turn off 
> all of the fans and disk, before this goes to the main kernel? Even with 
> APM, I can put the machine in standby/suspend, I just don't get fan 
> control, which is what I'd like.

You'll still be able to use APM.  ACPI is already in the kernel, this is
`just' an update.  It's not good to have this code so far diverged from
what's in the kernel -- many machines, including those I'm paid to work
on, need more recent ACPI code than that in the standard kernel.

-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
