From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH] MODSIGN: Add TAINT_NOKEY_MODULE
Date: Sun, 20 Jan 2013 19:19:39 -0500
Message-ID: <20130121001939.GB25509@redhat.com>
References: <20130104191205.GD27554@hansolo.jdub.homelinux.org> <87bod14x44.fsf@rustcorp.com.au> <20130107145832.GA12363@hansolo.jdub.homelinux.org> <20130115190911.GA6964@hansolo.jdub.homelinux.org> <87y5ftyf51.fsf@rustcorp.com.au> <20130116193724.GF6964@hansolo.jdub.homelinux.org> <87pq14y6bs.fsf@rustcorp.com.au> <20130117150202.GB32586@redhat.com> <8738xvxv55.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54185 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab3AUATx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2013 19:19:53 -0500
Content-Disposition: inline
In-Reply-To: <8738xvxv55.fsf@rustcorp.com.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dave Jones <davej@redhat.com>, Josh Boyer <jwboyer@redhat.com>, dhowells@redhat.com, linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

Hi -

> [...]
> -	add_taint(TAINT_DIE);
> +	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> [...]

If "UNRELIABLE" a good way to describe it - not DANGEROUS or
COUNTERPRODUCTIVE or something, then maybe lockdep *can* produce
reasonable results following such a taint.  If the results are merely
suspect, could lockdep reports include the taint report, but otherwise
keep working?

- FChE
