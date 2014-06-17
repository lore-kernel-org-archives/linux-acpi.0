From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/7 REVISION] trace, RAS: Add eMCA trace event interface
Date: Tue, 17 Jun 2014 08:59:16 -0400
Message-ID: <20140617085916.33a3a428@gandalf.local.home>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
	<1402553517-30208-1-git-send-email-gong.chen@linux.intel.com>
	<20140612092808.5f7bec5e@gandalf.local.home>
	<20140613021956.GA17509@gchen.bj.intel.com>
	<20140612230117.46758e3c@gandalf.local.home>
	<20140612230833.3c0f41b2@gandalf.local.home>
	<20140613070928.GA29351@gchen.bj.intel.com>
	<20140617020937.GA14404@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:27039 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755936AbaFQM7Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jun 2014 08:59:25 -0400
In-Reply-To: <20140617020937.GA14404@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Mon, 16 Jun 2014 22:09:37 -0400
"Chen, Gong" <gong.chen@linux.intel.com> wrote:


> 
> Any update, Steven?


Here, apply the below patch and then use "__field_struct()" instead of
"__field()". That should work. If so, I can add it to my repo (needs
some cleanup and documentation) in a separate branch that can be pulled
to base your patches on top of.

-- Steve

diff --git a/include/trace/ftrace.h b/include/trace/ftrace.h
index 0fd06fe..26b4f2e 100644
--- a/include/trace/ftrace.h
+++ b/include/trace/ftrace.h
@@ -44,6 +44,12 @@
 #undef __field_ext
 #define __field_ext(type, item, filter_type)	type	item;
 
+#undef __field_struct
+#define __field_struct(type, item)	type	item;
+
+#undef __field_struct_ext
+#define __field_struct_ext(type, item, filter_type)	type	item;
+
 #undef __array
 #define __array(type, item, len)	type	item[len];
 
@@ -122,6 +128,12 @@
 #undef __field_ext
 #define __field_ext(type, item, filter_type)
 
+#undef __field_struct
+#define __field_struct(type, item)
+
+#undef __field_struct_ext
+#define __field_struct_ext(type, item, filter_type)
+
 #undef __array
 #define __array(type, item, len)
 
@@ -315,9 +327,21 @@ static struct trace_event_functions ftrace_event_type_funcs_##call = {	\
 	if (ret)							\
 		return ret;
 
+#undef __field_struct_ext
+#define __field_struct_ext(type, item, filter_type)			\
+	ret = trace_define_field(event_call, #type, #item,		\
+				 offsetof(typeof(field), item),		\
+				 sizeof(field.item),			\
+				 0, filter_type);			\
+	if (ret)							\
+		return ret;
+
 #undef __field
 #define __field(type, item)	__field_ext(type, item, FILTER_OTHER)
 
+#undef __field_struct
+#define __field_struct(type, item) __field_struct_ext(type, item, FILTER_OTHER)
+
 #undef __array
 #define __array(type, item, len)					\
 	do {								\
@@ -379,6 +403,12 @@ ftrace_define_fields_##call(struct ftrace_event_call *event_call)	\
 #undef __field_ext
 #define __field_ext(type, item, filter_type)
 
+#undef __field_struct
+#define __field_struct(type, item)
+
+#undef __field_struct_ext
+#define __field_struct_ext(type, item, filter_type)
+
 #undef __array
 #define __array(type, item, len)
 
@@ -550,6 +580,9 @@ static inline notrace int ftrace_get_offsets_##call(			\
 #undef __field
 #define __field(type, item)
 
+#undef __field_struct
+#define __field_struct(type, item)
+
 #undef __array
 #define __array(type, item, len)
 
