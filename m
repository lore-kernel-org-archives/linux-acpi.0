From: Paul Menage <menage@google.com>
Subject: Re: [PATCH]cpuset: add new API to change cpuset top group's cpus
Date: Tue, 19 May 2009 12:55:18 -0700
Message-ID: <6599ad830905191255r13b6166fs105213faf30f229f@mail.gmail.com>
References: <20090519073942.GA10864@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:15579 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbZESTzV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 15:55:21 -0400
In-Reply-To: <20090519073942.GA10864@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, May 19, 2009 at 12:39 AM, Shaohua Li <shaohua.li@intel.com> wro=
te:
>
> This patch adds one API to change cpuset top group's cpus. If we want=
 to
> make one cpu idle, simply remove the cpu from cpuset top group's cpu =
list,
> then all tasks will be migrate to other cpus, and other tasks will no=
t be
> migrated to this cpu again. No functional changes.

>
> +int cpuset_change_top_cpumask(const char *buf)
> +{
> + =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 struct cpuset *cs =3D &top_cpuset;
> + =A0 =A0 =A0 struct cpuset *trialcs;
> +
> + =A0 =A0 =A0 if (!cgroup_lock_live_group(cs->css.cgroup))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;

top_cpuset can't possibly be dead, so a plain cgroup_lock() would be fi=
ne here.

> +
> + =A0 =A0 =A0 trialcs =3D alloc_trial_cpuset(cs);
> + =A0 =A0 =A0 if (!trialcs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;

You returned without doing a cgroup_unlock()

> +
> + =A0 =A0 =A0 retval =3D update_cpumask(cs, trialcs, buf, true);

This will fail if any child cpuset is using any cpu not in the new
cpumask, since a child's cpumask must be a subset of its parent's.

So this can't work without co-ordination with userspace regarding
child cpusets. Given that, it seems simpler to do the whole thing in
userspace, or just use the existing hotplug infrastructure.

Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
