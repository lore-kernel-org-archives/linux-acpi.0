From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control
	brightness with hotkeys
Date: Sun, 12 Apr 2009 02:04:05 -0300
Message-ID: <20090412050405.GB8211@khazad-dum.debian.net>
References: <49E10684.5090101@gmail.com> <20090411150555.8b13ed18.akpm@linux-foundation.org> <49E11FD0.9040403@gmail.com> <49E12378.8070200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752710AbZDLFEV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49E12378.8070200@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Niel Lambrechts <niel.lambrechts@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux.kernel" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 12 Apr 2009, Niel Lambrechts wrote:
> Okay, please bear with me (I'm a git novice) but when I did
> 
> 'git revert 0e501834f8c2ba7de2a56e332d346dcf4ac0b593'
> 
> and recompiled I was still unable to control the brightness with the
> hotkeys...

Which is not surprising.  None of those codepaths are active for your
thinkpad, at least not by default.

Try bissecting keyed to changes to the ACPI video driver, or to the whole
acpi directory (but do try Linus' latest git kernel, first. One never
knows...)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
