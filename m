From: Tony Luck <tony.luck@gmail.com>
Subject: Re: Extended H/W error log driver
Date: Tue, 15 Oct 2013 09:15:21 -0700
Message-ID: <CA+8MBbJeSJBDPcomupOuVBrnZNkMTNTXsoZY9yUbXPe9YrTFXg@mail.gmail.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
	<20131011080427.GC18719@pd.tnic>
	<20131014064940.GD12189@gchen.bj.intel.com>
	<20131014105533.GF4009@pd.tnic>
	<20131015040731.GA887@gchen.bj.intel.com>
	<20131015092851.GA7908@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131015092851.GA7908@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 15, 2013 at 2:28 AM, Borislav Petkov <bp@alien8.de> wrote:
> We can even add a hint for the user like:
>
>         "Above errors have been corrected by the hardware and require no further action."
>
> Btw, this is valid for both dmesg and trace event output.
>
> Because from my experience so far people just scream: "Look, I just had
> an MCE" withot even reading what it says. And this just upsets support
> people for no valid reason at all.

"Like", "+1", "metoo" ... or whatever it is we do on LKML to indicate
we approve.

-Tony
