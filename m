From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: New feature proposal "quickwakeup"
Date: Fri, 6 Nov 2009 17:03:21 +0000
Message-ID: <20091106170321.GA24312@srcf.ucam.org>
References: <1257523241.1318.367.camel@xhp836-11>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1257523241.1318.367.camel@xhp836-11>
Sender: linux-omap-owner@vger.kernel.org
To: Falempe Jocelyn <jocelyn.falempe@motorola.com>
Cc: linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hmm. This is an interesting approach. Just to understand the usecase 
better, though - my understanding is that Nokia's approach on Omap-based 
devices has been to treat "suspend" as a runtime state, without actually 
performing a systemwide transition. What are the constraints that make 
shifting into a different hardware state more efficient for you?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
