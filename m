From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Rationalise ACPI backlight implementation
Date: Mon, 28 Jan 2008 01:25:50 +0000
Message-ID: <20080128012549.GA24166@srcf.ucam.org>
References: <20071226020325.GA21099@srcf.ucam.org> <200801241644.49114.lenb@kernel.org> <20080126220045.b93db7c9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756726AbYA1B0V@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080126220045.b93db7c9.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 26, 2008 at 10:00:45PM -0800, Andrew Morton wrote:
> - Create a new /sys node with a new name which has the new semantics.

The semantics are the same as they always have been - values between 0 
and max_brightness are valid values. If you've made assumptions about 
what max_brightness is, then that's a bug in the userspace application 
rather than a change in the semantics of the interface.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
