From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [RFC] Add lspnp support for sysfs
Date: Fri, 13 Jan 2006 10:51:36 -0700
Message-ID: <200601131051.36906.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Add lspnp support for sysfs.  This makes it work with generic PNP
(including PNPACPI, PNPBIOS, ISAPNP) instead of just with PNPBIOS.
I'm particularly interested in ia64, which never has PNPBIOS, but
may have PNPACPI.

Note that PNPBIOS exposes raw resources in /proc/bus/pnp/<device>,
while for generic PNP, the kernel exposes already-decoded resources
in /sys/bus/pnp/devices/<device>/{resources,options}, so the output
looks a little different.

For example, old output (based on /proc/bus/pnp):

    00 PNP0c02 Motherboard resources
	flags: [no disable] [no config] [static]
	allocated resources:
	    io 0x0080-0x0080 [16-bit decode]
	    io 0xffbf-0xffbf [16-bit decode]
	    mem 0xfff80000-0xffffffff [8 bit] [r/o]

new output (from /sys/bus/pnp/devices/):

    00:00 PNP0c02 Motherboard resources
	state = active
	allocated resources:
	    io 0x80-0x80
	    io 0xffbf-0xffbf
	    mem 0xfff80000-0xffffffff

Feedback welcome.

diff -u -ur pcmcia-cs-3.2.9.orig/debug-tools/lspnp.c pcmcia-cs-3.2.9/debug-tools/lspnp.c
--- pcmcia-cs-3.2.9.orig/debug-tools/lspnp.c	2005-06-14 23:37:08.000000000 -0600
+++ pcmcia-cs-3.2.9/debug-tools/lspnp.c	2006-01-13 09:27:46.000000000 -0700
@@ -38,6 +38,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <dirent.h>
 #include <fcntl.h>
 #include <string.h>
 #include <endian.h>
@@ -501,13 +502,13 @@
     return (u_char *)p;
 }
 
-static void dump_resources(int num)
+static void dump_resources(char *name)
 {
     char fn[40];
     u_char buf[4096], *p;
     int fd, nr;
     
-    sprintf(fn, "/proc/bus/pnp/%s%02x", (boot ? "boot/" : ""), num);
+    sprintf(fn, "/proc/bus/pnp/%s%s", (boot ? "boot/" : ""), name);
     fd = open(fn, O_RDONLY);
     nr = read(fd, buf, sizeof(buf));
     close(fd);
@@ -528,24 +529,173 @@
     }
 }
 
-static int dump_basic(int match)
+static int match_device(char *name, char *match)
 {
-    int id, num, t1, t2, t3, flags;
+    char *dev;
+
+    if (name[0] == '.')
+	return 0;
+
+    /* no filter or exact match */
+    if (!match || !strcmp(name, match))
+	return 1;
+
+    /* let "01" match "xx:01" or "01" */
+    dev = strrchr(name, ':');
+    if (dev)
+	dev++;
+    else
+	dev = name;
+    if (!strcmp(dev, match))
+	return 1;
+
+    /* let "1" match "xx:01" or "01" */
+    while (*dev == '0')
+	dev++;
+    if (*dev == '\0')	/* saw "00", back up to "0" */
+	dev--;
+    if (!strcmp(dev, match))
+	return 1;
+
+    return 0;
+}
+
+#define SYSFS_PATH "/sys/bus/pnp/devices"
+
+static void sysfs_dump_resources(char *name)
+{
+    FILE *file;
+    char buf[256], *nl;
+    int first;
+    struct eisa_id *eid;
+
+    sprintf(buf, "%s/%s/resources", SYSFS_PATH, name);
+    file = fopen(buf, "r");
+    if (!file)
+	return;
+    first = 1;
+    fgets(buf, sizeof(buf), file);
+    printf("    %s", buf);	/* "state =" */
+    while (fgets(buf, sizeof(buf), file)) {
+	if (first && verbose > 1) {
+	    printf("    allocated resources:\n");
+	    first = 0;
+	}
+	printf("\t%s", buf);
+    }
+    fclose(file);
+
+    if (verbose < 2)
+	return;
+
+    sprintf(buf, "%s/%s/options", SYSFS_PATH, name);
+    file = fopen(buf, "r");
+    if (!file)
+	return;
+    first = 1;
+    while (fgets(buf, sizeof(buf), file)) {
+	if (first) {
+	    printf("    possible resources:\n");
+	    first = 0;
+	}
+	printf("\t%s", buf);
+    }
+    fclose(file);
+
+    sprintf(buf, "%s/%s/id", SYSFS_PATH, name);
+    file = fopen(buf, "r");
+    if (!file)
+	return;
+    first = 1;
+    fgets(buf, sizeof(buf), file);	/* skip first one */
+    while (fgets(buf, sizeof(buf), file)) {
+	if (first) {
+	    printf("    compatible devices:\n");
+	    first = 0;
+	}
+	nl = strchr(buf, '\n');
+	if (nl)
+	    *nl = '\0';
+	for (eid = eisa_id; eid; eid = eid->next)
+	    if (strcmp(buf, eid->id) == 0) break;
+	printf("\t%s %s\n", buf, eid ? eid->name : "(unknown)");
+    }
+    fclose(file);
+}
+
+static char *sysfs_get_string(char *name, char *object)
+{
+    int fd, len;
+    char *buf, *nl;
+
+    buf = malloc(256);
+    if (!buf)
+	return 0;
+    sprintf(buf, "%s/%s/%s", SYSFS_PATH, name, object);
+    fd = open(buf, O_RDONLY);
+    if (fd < 0)
+	return 0;
+    len = read(fd, buf, 256);
+    close(fd);
+    nl = strchr(buf, '\n');
+    if (nl)
+	*nl = '\0';
+    return buf;
+}
+
+static int sysfs_dump_basic(char *match)
+{
+    struct dirent **namelist;
+    char *name, *eis;
+    struct eisa_id *eid;
+    int i, n;
+
+    n = scandir(SYSFS_PATH, &namelist, 0, alphasort);
+    if (n < 0)
+	return -1;
+
+    for (i = 0; i < n; i++) {
+	name = namelist[i]->d_name;
+	if (match_device(name, match)) {
+	    eis = sysfs_get_string(name, "id");
+	    for (eid = eisa_id; eid; eid = eid->next)
+		if (strcmp(eis, eid->id) == 0) break;
+	    printf("%s %s %s\n", name, eis, eid ? eid->name : "(unknown)");
+	    if (verbose) {
+		sysfs_dump_resources(name);
+		if (!match) printf("\n");
+	    }
+	    free(eis);
+	}
+
+	free(namelist[i]);
+    }
+    free(namelist);
+    return 0;
+}
+
+static int dump_basic(char *match)
+{
+    int id, t1, t2, t3, flags;
     struct eisa_id *eid;
-    char *eis, buf[64];
+    char name[4], *eis, buf[64];
     FILE *f;
 
+    if (sysfs_dump_basic(match) == 0)
+	return 0;
+
     f = fopen("/proc/bus/pnp/devices", "r");
     if (f == NULL) {
-	fprintf(stderr, "lspnp: /proc/bus/pnp not available\n");
+	fprintf(stderr, "lspnp: neither %s nor /proc/bus/pnp is available\n",
+		SYSFS_PATH);
 	return -1;
     }
     while (fgets(buf, 63, f) != NULL) {
-	sscanf(buf, "%x %x %x:%x:%x %x", &num, &id, &t1, &t2, &t3, &flags);
-	if ((match >= 0) && (match != num))
+	sscanf(buf, "%2s %x %x:%x:%x %x", name, &id, &t1, &t2, &t3, &flags);
+	if (!match_device(name, match))
 	    continue;
 	eis = eisa_str(id);
-	printf("%02x %7s ", num, eis);
+	printf("%s %7s ", name, eis);
 	for (eid = eisa_id; eid; eid = eid->next)
 	    if (strcmp(eis, eid->id) == 0) break;
 	if (eid)
@@ -556,8 +706,8 @@
 	if (verbose > 1)
 	    dump_flags(flags);
 	if (verbose) {
-	    dump_resources(num);
-	    if (match < 0) printf("\n");
+	    dump_resources(name);
+	    if (!match) printf("\n");
 	}
     }
     fclose(f);
@@ -575,7 +725,6 @@
 int main(int argc, char *argv[])
 {
     int optch, errflg = 0;
-    char *s;
     
     while ((optch = getopt(argc, argv, "bv")) != -1) {
 	switch (optch) {
@@ -592,14 +741,11 @@
     load_ids();
     if (optind < argc) {
 	while (optind < argc) {
-	    int i = strtoul(argv[optind], &s, 16);
-	    if ((argv[optind] == '\0') || (*s != '\0'))
-		usage(argv[0]);
-	    if (dump_basic(i) != 0)
+	    if (dump_basic(argv[optind]) != 0)
 		return EXIT_FAILURE;
 	    optind++;
 	}
 	return EXIT_SUCCESS;
     }
-    return dump_basic(-1);
+    return dump_basic(NULL);
 }
diff -u -ur pcmcia-cs-3.2.9.orig/man/lspnp.8 pcmcia-cs-3.2.9/man/lspnp.8
--- pcmcia-cs-3.2.9.orig/man/lspnp.8	2000-06-12 15:24:49.000000000 -0600
+++ pcmcia-cs-3.2.9/man/lspnp.8	2006-01-13 09:27:46.000000000 -0700
@@ -11,9 +11,11 @@
 .RI [ "device ..." ]
 .SH DESCRIPTION
 This utility presents a formatted interpretation of the contents of the
+.I /sys/bus/pnp/devices
+or
 .I /proc/bus/pnp
 tree.  Its default output is a list of Plug and Play device node
-numbers, product identifiers, and descriptions.  Verbose output
+names, product identifiers, and descriptions.  Verbose output
 .RB ( -v )
 includes resource allocations (IO ports, memory, interrupts, and DMA 
 channels) for each device.  Very verbose output
@@ -22,7 +24,7 @@
 product identifiers for compatible devices.
 .PP
 The output can be limited to one or more specific device nodes by
-specifying their two-digit hex node numbers on the command line.  By
+specifying their node names on the command line.  By
 default, current (dynamic) device configuration information is
 displayed; with the
 .B -b
@@ -31,7 +33,10 @@
 .TP
 .B \-b
 Boot mode: read device resource information that will be used at next
-boot (as opposed to current resource info).
+boot (as opposed to current resource info).  This is supported only on
+kernels that provide the old
+.I /proc/bus/pnp
+interface.
 .TP
 .B \-v
 Selects more verbose output.  Can be used more than once.
@@ -40,8 +45,11 @@
 /usr/share/pnp.ids
 A database of known Plug and Play device ID's.
 .TP
-/proc/bus/pnp/...
+/sys/bus/pnp/devices/...
 The kernel interface for Plug and Play BIOS device services.
+.TP
+/proc/bus/pnp/...
+The old kernel interface for Plug and Play BIOS device services.
 .SH AUTHORS
 David Hinds \- dahinds-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
 .SH "SEE ALSO"
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
