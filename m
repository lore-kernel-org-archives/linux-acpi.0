From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: acpidump replaces acpidmp
Date: Wed, 27 Jul 2005 17:05:09 +0200
Message-ID: <42E7A2A5.3040103@suse.de>
References: <20050726192423.216b4be8.voluspa@telia.com>	<42E76A79.2040702@suse.de> <20050727154458.455d16db.voluspa@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050727154458.455d16db.voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Voluspa <voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Voluspa wrote:
> 24 -r--------  1 root root   24136 Jul 27 14:47 dsdt
> 28 -rw-r--r--  1 root root   24743 Jul 27 14:52 dsdt.acpidump
> 
> OK, I now know that acpidump gives me both fadt and dsdt and something
> more, hence the difference. But this is usability madness; 1) The
> documentation of program switches, Both README and source, swing between
> mildly accurate and inaccurate; 2) Having to dump/decode in several
> steps here (not really knowing if you've made an error) and then later
> in iasl as well.
> 
> Compared to just copying dsdt from /proc and following all the tutorials
> online on how to modify it, this hackery is not sane.
> 
It's not that bad:
(using the old acpidmp. I expect it works the same with acpidump, but
I couldn't get any output with my short tries ...)

acpidmp > /tmp/acpidmp
acpixtract dsdt /tmp/acpidmp >/tmp/dsdt
acpixtract ssdt /tmp/acpidmp >/tmp/ssdt

iasl -d /tmp/dsdt
if you have a ssdt:
iasl -d /tmp/ssdt

Now you can edit /tmp/ssdt.dsl and /tmp/dsdt.dsl

     Thomas


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
