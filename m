From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Fri, 30 Apr 2010 18:44:47 +0100
Message-ID: <20100430174447.GA14889@srcf.ucam.org>
References: <20100126084740.GA5265@jgarrett.org> <87y6jkee1b.fsf@basil.nowhere.org> <20100205160900.GA2736@jgarrett.org> <alpine.LFD.2.00.1002051238280.4050@localhost.localdomain> <20100426194002.586fbaa5@fido5> <20100427124703.GA16706@jgarrett.org> <alpine.LFD.2.00.1004301218280.2489@sony>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004301218280.2489@sony>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jeff Garrett <jeff@jgarrett.org>, Philip Langdale <philipl@overt.org>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 30, 2010 at 12:25:44PM -0400, Len Brown wrote:

> I am hopeful that the "right thin to do" is to not look at bm-status
> and that perhaps there is a bug where we are looking at it
> "by mistake".

https://patchwork.kernel.org/patch/58962/ - it seems to be a win.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
