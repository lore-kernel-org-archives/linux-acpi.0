From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] x86/smpboot: Make the check code more clear in
 prefill_possible_map()
Date: Tue, 20 Mar 2018 13:39:18 +0100
Message-ID: <20180320123918.GS4043@hirez.programming.kicks-ass.net>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
 <20180320110432.28127-4-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180320110432.28127-4-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, hpa@zytor.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 20, 2018 at 07:04:30PM +0800, Dou Liyang wrote:
> case 1: no  | no  | no | -->  min (setup_possible_cpus, nr_cpu_ids, setup_max_cpus)
> case 2: no  | no  | yes| -->  min (setup_possible_cpus, nr_cpu_ids)
> case 3: no  | yes | no | -->  1                                    
> case 4: no  | yes | yes| -->  1
> case 5: yes | no  | no | -->  min (num_processors, nr_cpu_ids, setup_max_cpus)
> case 6: yes | no  | yes| -->  min (num_processors + disabled_cpus, nr_cpu_ids)
> case 7: yes | yes | no | -->  1 
> case 8: yes | yes | yes| -->  1

The case number is off by one ;-)
