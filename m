From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Thu, 26 May 2005 18:00:56 +0200
Message-ID: <200505261800.56897.rjw@sisk.pl>
References: <200503291156.19112.rjw@sisk.pl> <20050525212357.0b28cbb3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050525212357.0b28cbb3.akpm-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, 26 of May 2005 06:23, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> >
> > Hi,
> > 
> > There is a problem on my box (Asus L5D, x86-64 kernel) with the ACPI battery
> > driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely, the battery monitor that
> > I use (the kpowersave applet from SUSE 9.2) is no longer able to report the
> > battery status (ie how much % it is loaded).  It can only check if the AC power
> > is connected (if it is connected, kpowersave behaves as though there was
> > no battery in the box, and if it is not connected, kpowersave always shows
> > that the battery is 1% loaded).
> > 
> > Also, there are big latencies on loading and accessing the battery module, but
> > the module loads successfully and there's nothing suspicious in dmesg.
> > 
> 
> Are these problems still present in 2.6.12-rc5 or 2.6.12-rc5-mm1?

2.6.12-rc5 is unaffected, as it does not contain the patch that causes
the problem to appear.

The problem is still present in 2.6.12-rc5-mm1.  I have created a bugzilla entry
for it at http://bugzilla.kernel.org/show_bug.cgi?id=4665

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
