From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 16:31:24 -0300
Message-ID: <20070315193123.GB14394@khazad-dum.debian.net>
References: <11736588493609-git-send-email-hmh@hmh.eng.br>
	<20070315031015.GA6292@khazad-dum.debian.net>
	<20070315031251.GB6292@khazad-dum.debian.net>
	<200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070315110156.09e80b99.kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 15 Mar 2007, Kristen Carlson Accardi wrote:
> I think we should focus our efforts on a generic (non platform specific) 
> solution that can work across many laptops (i.e. ACPI_BAY).  Let's make

Agreed, as long as that doesn't mean we have to pollute ACPI_BAY with a
truckload of crap required to deal with vendor/model-specific idioticities.
I hope ThinkPads are not like that, but I am not sure, and I'd feel bad
about adding a lot of quirks to ACPI_BAY because of ThinkPad weirdness :p

Otherwise, it would be best to allow model-specific modules to provide extra
functionality for ACPI_BAY, that way we have generic code, and we can
contain the braindamage to where it belongs (e.g. in ibm-acpi).

> so if you do have time to work on this, that would be great.  I am happy 
> to test on the set of laptops I've got.

I will see what I can do.  My "first approach" at a requirements list for a
proper bay module are as follows:

1. It will handle all device types (ATAPI, PATA, SATA, batteries);

2. It will do the right thing on plug and unplug.  This means telling the
rest of the kernel to disable the device in the bay, for example.  Right now
we shutdown one end of the PATA/SATA link on ThinkPads eletrically, and
leave libata to scream blood murder until it disables its end due to too
many retries, for example;

3. It will allow model-specific drivers (like ibm-acpi) to be notified of
bay events (callbacks or a notifier chain, since ACPICA doesn't allow for
more than one driver notifier per handle) and to request an immediate
attempt of ejection or hotplug/bay device change verification.  Some
thinkpads benefit from an eject before S3 sleep -- as long as what is inside
is not a battery...

I don't see why the generic driver could not do all of the above.  But it
will take a while to get there :-)  And no, ibm-acpi can't do much more than
(1).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
