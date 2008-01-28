From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] Allocate pnp resources dynamically via krealloc	-	working
 version
Date: Mon, 28 Jan 2008 16:00:32 +0100
Message-ID: <479DEE10.6060203@keyaccess.nl>
References: <1200772810.3708.42.camel@queen>	 <84144f020801191623i2ad344a8t1c40969578793d13@mail.gmail.com>	 <1201109917.20940.214.camel@queen.suse.de>  <479CD935.3070906@keyaccess.nl> <1201530103.20940.413.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761410AbYA1PAc@vger.kernel.org>
In-Reply-To: <1201530103.20940.413.camel@queen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.de
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, Jaroslav Kysela <perex@perex.cz>
List-Id: linux-acpi@vger.kernel.org

On 28-01-08 15:21, Thomas Renninger wrote:

> I think I know what is going on.
> While pnpbios and pnpacpi theoretically do not have limits, isapnp has
> spec restrictions (AFAIK, I have not read this up, but taken over from
> previous implementation...).
> Therefore in isapnp I wanted to stay with:
> #define PNP_MAX_PORT            8
> #define PNP_MAX_MEM             4
> #define PNP_MAX_IRQ             2
> #define PNP_MAX_DMA             2
> but I have forgotten to malloc one portion for each at init time, or
> even better one portion as soon as one is needed.

Yup.

> As said, isapnp is more or less untested, thanks a lot for trying out.
> I will send an updated version soon.

I"m not sure of the flow of things by the way but if it makes better/nicer 
code to just pretend that ISAPnP is also unlimited then I'd say to simply do 
so. ISAPnP is getting obsolete anyway, not anything to optimise for...

Rene.
