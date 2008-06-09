From: "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Mon, 09 Jun 2008 09:39:39 -0700
Message-ID: <484D5CCB.10302@intel.com>
References: <20080606140846.GA9580@ucw.cz>	<20080607213918.GC1746@elf.ucw.cz> <20080607145435.4afc9812@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757745AbYFIQli@vger.kernel.org>
In-Reply-To: <20080607145435.4afc9812@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, cpufreq@lists.linux.org.uk, davej@codemonkey.org.uk
List-Id: linux-acpi@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 7 Jun 2008 23:39:18 +0200
> Pavel Machek <pavel@suse.cz> wrote:
> 
>>> # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
>>> 800000
>>> # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
>>> 800000
>>>
>>>
>>> This renders my Dothan to utterly poor speeds. (standard T43)
>>>
>>> performance cpufreq governor makes no difference - I still can't
>>> change the frequency upper/lower values.
>> Hmm, I have similar problem in Novell bugzilla, on very different hw:
>>
>> https://bugzilla.novell.com/show_bug.cgi?id=396311
>>
>> 								Pavel
>>
> 
> 
> are either of you running gnome-power-manager or kpowersaved ?
> sometimes these programs (and more likely, the patches added by a
> distro maintainer who doesn't fully realize how power works) tend to
> muck with kernel settings around CPU frequency that they have
> absolutely no business touching...

I neither run gnome nor kde. there's nothing running on this box that is managing
power settings.

Auke
