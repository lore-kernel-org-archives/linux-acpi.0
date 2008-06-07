From: Holger Macht <hmacht@suse.de>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Sun, 8 Jun 2008 01:36:40 +0200
Message-ID: <20080607233640.GA9266@homac>
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
Cc: len.brown@intel.com, auke-jan.h.kok@intel.com, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org

On Sat 07. Jun - 14:54:35, Arjan van de Ven wrote:
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
> > 
> > 								Pavel
> > 
> 
> 
> are either of you running gnome-power-manager or kpowersaved ?
> sometimes these programs (and more likely, the patches added by a
> distro maintainer who doesn't fully realize how power works) tend to
> muck with kernel settings around CPU frequency that they have
> absolutely no business touching...

I'm not aware of any 'brand' of kpowersave or gnome-power-manager which
could interfere here. Nor I'm aware of any backends in recent distros
which tweak the 'max freq' knobs. So I don't think this can be related. Or
please be a little bit more detailed about what you're referring to...

Regards,
	Holger
