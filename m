From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCHSET] workqueue: update workqueue users - replace
 create_workqueue()
Date: Tue, 25 Jan 2011 11:26:54 -0500
Message-ID: <20110125162654.GA4795@redhat.com>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
 <20110125142921.GB27510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110125142921.GB27510@htj.dyndns.org>
Sender: cpufreq-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 25, 2011 at 03:29:21PM +0100, Tejun Heo wrote:
 > Hello,
 > 
 > There was no response for the following patches and I'm planning on
 > routing them through workqueue#for-2.6.39.  If you have an objection
 > or want to take the patch through a different tree, please let me
 > know.
 > ..
 >  0007-cpufreq-use-system_wq-instead-of-dedicated-workqueue.patch

Feel free to add my 
Signed-off-by: Dave Jones <davej@redhat.com> 
to this.

I looked it over, and didn't see anything objectionable.

	Dave
