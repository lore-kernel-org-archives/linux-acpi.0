From: Pavel Machek <pavel@suse.cz>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Mon, 16 Jun 2008 12:42:00 +0200
Message-ID: <20080616104159.GA28659@elf.ucw.cz>
References: <20080606140846.GA9580@ucw.cz> <20080607213918.GC1746@elf.ucw.cz>
	<20080607145435.4afc9812@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20080607145435.4afc9812@infradead.org>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Arjan van de Ven <arjan@infradead.org>
Cc: davej@codemonkey.org.uk, auke-jan.h.kok@intel.com, len.brown@intel.com, cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat 2008-06-07 14:54:35, Arjan van de Ven wrote:
> On Sat, 7 Jun 2008 23:39:18 +0200
> Pavel Machek <pavel@suse.cz> wrote:
> 
> > > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > > 800000
> > > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > > 800000
> > > 
> > > 
> > > This renders my Dothan to utterly poor speeds. (standard T43)
> > > 
> > > performance cpufreq governor makes no difference - I still can't
> > > change the frequency upper/lower values.
> > 
> > Hmm, I have similar problem in Novell bugzilla, on very different hw:
> > 
> > https://bugzilla.novell.com/show_bug.cgi?id=396311

> are either of you running gnome-power-manager or kpowersaved ?
> sometimes these programs (and more likely, the patches added by a
> distro maintainer who doesn't fully realize how power works) tend to
> muck with kernel settings around CPU frequency that they have
> absolutely no business touching...

In novel bugzilla case ignore_ppc=1 helped, so it seems to be BIOS
problem, not userland's...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
