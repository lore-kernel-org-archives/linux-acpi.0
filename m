From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.21 known regressions (v2) (for -stable team)
Date: Sat, 28 Apr 2007 19:18:20 +0200
Message-ID: <6bffcb0e0704281018h68a6d63fw8747b63bc1b86a4b@mail.gmail.com>
References: <463375E5.5040108@googlemail.com>
	 <200704281252.20381.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <200704281252.20381.gene.heskett@gmail.com>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Riccardo Ricci <rricci@nuovanetmore.it>, "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>, Len Brown <len.brown@intel.com>, David Brownell <david-b@pacbell.net>, Jeff Mahoney <jeffm@suse.com>, reiserfs-dev@namesys.com, Jeff Chua <jeff.chua.linux@gmail.com>, Francois SIMOND <curio@free.fr>, Stephen Hemminger <shemminger@linux-foundation.org>, netdev@vger.kernel.org, =?ISO-8859-1?Q?H=E5kan_Lindqvist?= <lindqvist@netstar.se>, Vincent Frentzel <zcecc22@ucl.ac.uk>, =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <francois.valenduc@skynet.be>, Thomas Meyer <thomas.mey@web.de>, Giorgio Lando <patroclo7@gmail.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner
List-Id: linux-acpi@vger.kernel.org

Hi Gene,

On 28/04/07, Gene Heskett <gene.heskett@gmail.com> wrote:
> On Saturday 28 April 2007, Michal Piotrowski wrote:
> >Hi all,
> >
> >Here is a list of known regressions reported after 2.6.21 release.
> >
> >Feel free to add new regressions/remove fixed etc.
> >http://kernelnewbies.org/known_regressions
> >
> I went here, but without a login the page is immutable
>
> Therefore I'll add it here
>
> Subject         :proprietary belkin upsd turns into cpu hog

I'm not sure if I understand correctly. Is it a proprietary driver?
If so, it's not a task for -stable team.

> Submitter       :gene.heskett@gmail.com
> Reference       :something changed in how /dev/ttyUSB's handle 1 and 2 byte messages
> from pl2303 usb<->serial adaptors.  Also, assignation of ttyUSB#'s is
> volatile depending on phase of the moon when booted.

Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
