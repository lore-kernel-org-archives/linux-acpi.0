From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Reading /proc/acpi/battery/BAT0/info causes high latency on Dell Lattitude D800
Date: Mon, 28 Mar 2005 22:45:34 +0200
Message-ID: <20050328204534.GA28568@message-id.gmane0305.slipkontur.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC15F@pdsmsx403> <16965.56265.916668.235316@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16965.56265.916668.235316-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>
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

On Sun, Mar 27, 2005 at 08:01:45AM +1000, Neil Brown wrote:
> On Saturday March 26, luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> > Do you have this kind of problem before? Or just this kernel.

it started being this bad between 2.6.10-rc2-bk9 and 2.6.10-rc2-bk10.
But only with CONFIG_ACPI_DEBUG

> Yes, I've had it for quite a while.  I don't remember a time when I
> didn't have it.  It has just slowly become more and more annoying (not
> worse, just more annoyig) so that I have decided to do something about
> it.

i reported the same on february 4th in a mail with subject
"Bad battery regression on Dell D600 from 2.6.10-rc2-bk9 to 2.6.10-rc2-bk10"

The "solution" (although a bad one IMO) was to turn CONFIG_ACPI_DEBUG off.
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
