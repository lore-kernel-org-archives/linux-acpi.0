From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI on hp Tablet TC1100
Date: Fri, 25 Mar 2005 04:11:26 +0000
Message-ID: <1111723887.11677.33.camel@tyrosine>
References: <Pine.LNX.4.58.0503241657510.4376@dashnine>
	 <1111704587.11677.27.camel@tyrosine>
	 <Pine.LNX.4.58.0503241901440.4867@dashnine>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0503241901440.4867@dashnine>
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

On Thu, 2005-03-24 at 19:24 -0500, Joshua Wise wrote:

> With those two, I get my console back after resuming, but no USB. If I had
> actually remembered to plug the access point back in, I'm pretty sure
> wireless would work.

Unload USB modules before suspend, and reload them after resume. You
probably want to write a script to do this.

> I guess I should try starting X and doing a susp/res from there as the
> logical next step. Testing... Hangs up on resume, no wifi on resume... dunno
> if that's an artifact of nvidia just being initialized (and hence hanging)
> first, or what.

Seriously, give up on the nvidia driver if you want working ACPI. It
just doesn't work properly. If I had the source code I'd try to debug
it, but, well...

> By the way, I noticed you're on freenode IRC -- you might be intereted in
> #acpi4linux, a channel presently consisting of, er, me, but hopefully soon
> others. (Or is there an IRC chan elsewhere that I didn't otherwise know of?)

Sounds like a good plan. I'm heading away for the weekend - I'll see
about this next week.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
