From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] [-mm] FS: file name must be unique in the same dir in
	procfs
Date: Tue, 11 Sep 2007 14:43:23 +0800
Message-ID: <1189493003.22038.30.camel@localhost.localdomain>
References: <1187605699.2920.147.camel@acpi-hp.sh.intel.com>
	 <200708201245.17780.oliver@neukum.org>
	 <1187625005.2920.167.camel@acpi-hp.sh.intel.com>
	 <20070910004927.323763ad.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40772 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760648AbXIKGjC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Sep 2007 02:39:02 -0400
In-Reply-To: <20070910004927.323763ad.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oliver Neukum <oliver@neukum.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 2007-09-10 at 15:49 +0800, Andrew Morton wrote:
> On Mon, 20 Aug 2007 23:50:05 +0800 Zhang Rui <rui.zhang@intel.com>
> wrote:
> 
> > Hi, Oliver,
> > Thanks for your comments,
> >
> > On Mon, 2007-08-20 at 18:45 +0800, Oliver Neukum wrote:
> > > Am Montag 20 August 2007 schrieb Zhang Rui:
> > > > Files name must be unique in the same directory.
> > > >
> > > > Bug is reported here:
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=8798
> > >
> > > Then I'd say fix the callers.
> > But at least the callers need to be told that something is wrong
> first.
> >
> > >  This will paper over bugs.
> > Hmm, what kind of bugs?
> > callers always need to check the return value when calling
> > proc_mkdir/create_proc_entry, don't they?
> >
> 
> Yes, but there's some risk that such a change will cause a
> presently-working system to stop working.  It's quite likely, if that
> system is checking the procfs-creation return value.
Yes, that's true.
I checked several systems and didn't find any similar problems.
I think this situation is rare.
Besides, duplicate names are totally unusable for user space.
We should fix this kind of bugs ASAP if there are any.

> So I think it'd be best if we were to detect the duplication and print
> a
> warning (which should include, if possible, the full pathname and a
> dump_stack()) and then the code should proceed as normal: permit the
> duplicated entry and return success.
> Then, when such duplicates are reported, we can work out what to do
> about
> them on a case-by-case basis.
Please review the patch below. :)
dump_stack is enough to debug the problem, so only the current duplicate
file names are printed out instead of the full pathname.

From: Zhang Rui <rui.zhang@intel.com>
File name should be unique in the same directory.

In order to keep the back-compatibility, only a warning is given
currently, but actions must be taken to fix it when such duplicates
are detected.

Bug report and a simple fix can be found here: 
http://bugzilla.kernel.org/show_bug.cgi?id=8798

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 fs/proc/generic.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/fs/proc/generic.c
===================================================================
--- linux-2.6.orig/fs/proc/generic.c
+++ linux-2.6/fs/proc/generic.c
@@ -523,6 +523,7 @@ static const struct inode_operations pro
 
 static int proc_register(struct proc_dir_entry * dir, struct
proc_dir_entry * dp)
 {
+	struct proc_dir_entry *tmp = NULL;
 	unsigned int i;
 	
 	i = get_inode_number();
@@ -547,11 +548,22 @@ static int proc_register(struct proc_dir
 	}
 
 	spin_lock(&proc_subdir_lock);
+
+	for (tmp = dir->subdir, i = 0; tmp && !i; tmp = tmp->next)
+		if (!strcmp(dp->name, tmp->name))
+			i = 1;
+
 	dp->next = dir->subdir;
 	dp->parent = dir;
 	dir->subdir = dp;
 	spin_unlock(&proc_subdir_lock);
 
+	if (i) {
+		printk(KERN_WARNING
+			"Duplicate file names \"%s\" detected.", dp->name);
+		dump_stack();
+	}
+
 	return 0;
 }
 
