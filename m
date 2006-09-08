From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Date: Fri, 8 Sep 2006 10:48:45 -0700
Message-ID: <20060908104845.c67b173d.kristen.c.accardi@intel.com>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com>
	<1157679256.3474.48.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751031AbWIHRs4@vger.kernel.org>
In-Reply-To: <1157679256.3474.48.camel@nigel.suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Fri, 08 Sep 2006 11:34:16 +1000
Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> Hi Kristen.
> 
> Great to see this!
> 
> Allow me to anticipate a question I'm sure will come: will this play
> well with (say) suspending while docked and resuming undocked?
> 

Hi Nigel,
I don't know.  the few experiments that I've tried with suspend/resume are
not inspiring.  I don't think that suspend/resume works at all with the
dock station ATM.  "warm plug" is something that is on my list of things
to work on after hot plug actually works.

Kristen
