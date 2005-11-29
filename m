From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: ACPI generic hotkey working on SONY (was: sony vaio pcg-k45 hell)
Date: Tue, 29 Nov 2005 16:35:01 +0100
Message-ID: <20051129153501.GB11822@message-id.s3e.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC212@pdsmsx403> <20051024102231.GA32705@message-id.gmane0305.slipkontur.de> <200510261029.01166.luming.yu@intel.com> <200511251602.02494.luming.yu@intel.com> <20051125120522.GA26643@message-id.s3e.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051125120522.GA26643-l0tNAEGuAhiXoBlonBaIS7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 25, 2005 at 01:05:22PM +0100, Stefan Seyfried wrote:

> > If so, acpi is fully responsible for hotkey function by keystroke.
> > If not, please verify http://bugzilla.kernel.org/show_bug.cgi?id=4876#c4 works 
> > or not. This is proc file stuff for hotkey function by issuing command from 
> > shell. 
> 
> I'm trying this out but may only get to it on monday or tuesday next week.

setting brightness works on the vgn-f115b with the patch after fixing it up
for 2.6.14.2 (attached, the most nasty one was the missing
EXPORT_SYMBOL(acpi_scan_ids) :-)

I have of course some other questions:
- what will happen on other machines if i load the hotkey module and issue
  echo "10001:1:1:0" >/proc/acpi/hotkey/action
  - will it crash?
  - will it just not work?
  - will it just work, so this is a generic solution?
- will it also work on my panasonic which right now needs pcc_acpi?
  (i will check this one out soon)
- if the "10001:1:1:0" is not a generic string for all machines (i am afraid
  it isn't), how do i find out what to put into /proc/acpi/hotkey/action?

Another problem is that for distributions to be able to use this stuff, it
must not depend on the "acpi_generic_hotkey=1" parameter. Can't we decide at
module load time if we want to use the generic or the vendor specific hotkey
interface?
Having the user select which machine he has _before_ installing with some
cryptic boot parameter is something i'd like to avoid.

Also i see that now some sony-specific stuff is in the generic hotkey driver.
Will we have to add specific stuff for all other vendor specific drivers if
we want to merge their functionality into hotkey.c?
-- 
Stefan Seyfried

--T4sUOijqQbZv57TR
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="hotkey-sony-2.6.14.2.patch.gz"
Content-Transfer-Encoding: base64

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

--T4sUOijqQbZv57TR--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
