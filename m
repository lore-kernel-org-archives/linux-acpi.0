From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V8 3/3] irqchip: qcom: Add IRQ combiner driver
Date: Tue, 13 Dec 2016 10:21:57 -0800
Message-ID: <1481653317.29291.19.camel@perches.com>
References: <1480460259-8585-1-git-send-email-agustinv@codeaurora.org>
         <1480460259-8585-4-git-send-email-agustinv@codeaurora.org>
         <b009635d-8a10-5e22-4438-0019d79d01d3@arm.com>
         <78bfd90d47200347628f7dd98451122f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:58033 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932241AbcLMSWK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Dec 2016 13:22:10 -0500
In-Reply-To: <78bfd90d47200347628f7dd98451122f@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, guohanjun@huawei.com, charles.garcia-tobin@arm.com

On Tue, 2016-12-13 at 10:23 -0500, Agustin Vega-Frias wrote:
> On 2016-12-07 13:16, Marc Zyngier wrote:
> > > +	}
> > > +
> > > +	combiner->domain = irq_domain_create_linear(
> > > +		pdev->dev.fwnode, combiner->nirqs, &domain_ops, combiner);
> > 
> > On a single line, please. Do no listen to the checkpatch police that
> > will tell you otherwise. It really hurt my eyes to see this opening
> > bracket and *nothing* after that.
> 
> Will do.

It seems generally preferred to have at least one argument on the
same line as the function being called.

So, here are some options:

Maximally fill the lines to 80 columns with the value being set
and function call while aligning to open parenthesis

	combiner->domain = irq_domain_create_linear(pdev->dev.fwnode,
						    combiner->nirqs,
						    &domain_ops, combiner);

Use a separate line for the function call:

	combiner->domain =
		irq_domain_create_linear(pdev->dev.fwnode, combiner->nirqs,
					 &domain_ops, combiner);

Or just ignore the 80 column limit wherever you deem appropriate.

No single style is universal, use what you think best.

Anyway, long identifiers (24 chars here) make staying within the
"strongly preferred" 80 column limit produce quite silly looking
code.
