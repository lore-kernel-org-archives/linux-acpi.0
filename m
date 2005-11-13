From: Sven Hoexter <sven-ckv7mInNtAwb1SvskN2V4Q@public.gmane.org>
Subject: Re: broken acpi support for battery 2.6.14
Date: Sun, 13 Nov 2005 11:53:55 +0100
Message-ID: <20051113105355.GA5057@sven.home.hoaxter.de>
References: <baf307070511130204h31c7f6bfv35067ce4c53fd868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <baf307070511130204h31c7f6bfv35067ce4c53fd868-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Nov 13, 2005 at 03:34:31PM +0530, Kevin Verma wrote:
> Hello,
> 
> I am continuesly noticing that the battery status being shown as NA
> and it is not possible to see the charge remaining via "Gnome battery
> charge monitor" while the output from /proc FS  and dmesg are as below
It's a problem with preempt in your kernel.
Please take a look at the following threads:
http://marc.theaimsgroup.com/?l=acpi4linux&m=113102890512735&w=2
http://marc.theaimsgroup.com/?l=acpi4linux&m=113143773517580&w=2

HTH
Sven
-- 
If God passed a mic to me to speak
I'd say stay in bed, world
Sleep in peace
   [The Cardigans - 03:45: No sleep]


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
