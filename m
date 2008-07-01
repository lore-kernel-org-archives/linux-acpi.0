From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH 1/7] ACPI: thinkpad-acpi: minor
	refactor on radio	switch init
Date: Tue, 1 Jul 2008 15:59:58 -0300
Message-ID: <20080701185958.GA5693@khazad-dum.debian.net>
References: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br>
	<1214936875-4812-2-git-send-email-hmh@hmh.eng.br>
	<486A7B20.4020502@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <486A7B20.4020502-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 01 Jul 2008, Andi Kleen wrote:
> Henrique de Moraes Holschuh wrote:
> > Change the code of hotkey_init, wan_init and bluetooth_init a bit to make it
> > much easier to add some Kconfig-selected debugging code later.
> 
> The later seems to be wrong, the debugging code is already included?

No, that patch just moves some code around and changes the way some
conditionals were written so it would be easier to add the debugging
code later.  It is supposed to change nothing as far as functionality
goes.

I do have that debugging code, but I didn't see a reason to submit it
for mainline yet.  But it helps me a whole deal if it is easy to just
patch it in when I needed it, so patch 1/7 is something I'd like merged.

The debugging code itself is a harness to simulate the thinkpad rfkill
firmware, as my T43 doesn't have bluetooth, WWAN or the WLSW rfkill
switch and I needed a way to test those codepaths.  As I said, it is a
separate patch I didn't submit yet (and might decide not to submit at
all, unless someone asks for it or I find out it would be helpful to
track some sort of bug).

I.e. the patch does exactly what the description says :-)

But I have nothing against changing that description, I just don't know
what to put in there that would be better...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
