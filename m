From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Date: Tue, 5 Apr 2005 18:31:44 -0700
Message-ID: <20050405183144.50ed3a9c.akpm@osdl.org>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at>
	<20050405204107.GD1380@elf.ucw.cz>
	<20050405210041.GA16263@gamma.logic.tuwien.ac.at>
	<20050405211340.GF1380@elf.ucw.cz>
	<20050405221903.GA21196@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050405221903.GA21196-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Cc: pavel-+ZI9xUNit7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Norbert Preining <preining-DX+603jRYB8@public.gmane.org> wrote:
>
> On Die, 05 Apr 2005, Pavel Machek wrote:
> > Well, I do not have working suspend-to-RAM setup close to me... Could
> > you try 2.6.12-rc1 to see if reboot problem is -mm specific or not?
> 
> 2.6.12-rc2 suspends and resumes with the very same config file (well,
> after running make oldconfig) without any problem.
> 
> So there is a change in -mm1 which triggers this. Should I start with
> backing out bk-acpi? or anything else?

bk-acpi would be a good choice.  It might be easier to start with
2.6.12-rc2 and add stuff, see when it breaks.

bk-acpi and bk-driver-core would be prime suspects.

Thanks for the help on this.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
