From: Voluspa <lista1-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: Re: 2.6.15-rc5-mm1
Date: Wed, 14 Dec 2005 05:04:28 +0100
Message-ID: <20051214050428.21d3f224.lista1@telia.com>
References: <20051210111557.18ba5fc8.lista1@telia.com>
	<200512101320.18779.rik@osrc.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200512101320.18779.rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Roman I Khimov <rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 10 Dec 2005 13:20:15 +0300 Roman I Khimov wrote:
> | Voluspa:
> > Nope, neither "nocst" nor "acpi=nocst" gave me back the C1
> > functionality...
> 
> Yep, same here, just tried.

Sorry about the red herring. I've patched 2.6.14 with the two acpi
suggestions for this stable series that Greg KH posted (both single and
combined):

[patch 10/26] ACPI: Prefer _CST over FADT for C-state capabilities
http://marc.theaimsgroup.com/?l=linux-kernel&m=113446277408937&w=2

[patch 12/26] ACPI: Add support for FADT P_LVL2_UP flag
http://marc.theaimsgroup.com/?l=linux-kernel&m=113446277427267&w=2

I thought nr 10 was the cause for the C-state regression, but neither
effected my machine. C1 was used as it should. Now, I don't have the
stomach for an un-cheerleaded "git bisect" of approximately four hours
to find the real culprit. So unless someone waves the pompoms I'll slip
quietly into the shadows, hoping the issue will disappear by itself
before 2.6.15 is finalized.

Mvh
Mats Johannesson
--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
